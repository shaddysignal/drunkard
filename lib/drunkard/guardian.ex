defmodule Drunkard.Guardian do
  use Guardian, otp_app: :drunkard

  alias Drunkard.Accounts.TokenAuthority

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.uuid)}
  end

  def after_encode_and_sign(_resource, %{"sub" => sub} = _claims, token, _opts) do
    {:ok, _stored} = TokenAuthority.store_token(sub, token)
    {:ok, token}
  end

  def on_verify(%{"sub" => sub} = claims, _token, _opts) do
    case TokenAuthority.find_token(sub) do
      {:error, reason} -> {:error, reason}
      {:ok, _found} -> {:ok, claims}
    end
  end

  @spec on_refresh({binary, %{sub: String.t()}}, {binary, %{sub: String.t()}}) :: {:error, :there_is_no_flesh} | {:ok, {binary, map}, {binary, map}}
  def on_refresh({ old_token, %{"sub" => old_sub} = old_claims },
                 { new_token, %{"sub" => new_sub} = new_claims }) do
    with {:ok, [_deleted_pair]} <- TokenAuthority.remove_token(old_sub),
          {:ok, [_saved_pair]} <- TokenAuthority.store_token(new_sub, new_token) do
      {:ok, {old_token, old_claims}, {new_token, new_claims}}
    else
      {:error, :spoon_is_not_there} -> {:error, :there_is_no_flesh}
      {:error, :something_is_nil} -> {:error, :there_is_nil_flesh}
    end
  end

  def on_revoke(%{"sub" => sub} = claims, _token, _opts) do
    {:ok, _deleted} = TokenAuthority.remove_token(sub)

    {:ok, claims}
  end

  def resource_from_claims(%{"sub" => uuid} = _claims) do # sub is the key under which subject is stored
    # Apperently, my idea is that it stupid to load user every request. So, resource will be just a string. Which is a little not symmetric
    {:ok, uuid}
  end
end
