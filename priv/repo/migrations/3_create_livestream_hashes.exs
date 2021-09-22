defmodule Fslc.Repo.Migrations.CreateLivestreamHashes do
  use Ecto.Migration

  def change do
    create table(:livestreams) do
      add :hash, :string, size: 64, default: fragment("md5(CONCAT('',random()))")
      add :expiration, :naive_datetime, default: fragment("(now() + interval '5 minutes')")
    end
  end
end
