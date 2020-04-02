defmodule AdoptopossWeb.RepoLiveTest do
  use AdoptopossWeb.LiveCase

  alias Adoptoposs.Tags.Tag

  test "disconnected mount of /settings/repos/:orga_id when logged out", %{conn: conn} do
    conn = get(conn, Routes.live_path(conn, AdoptopossWeb.RepoLive, "orga"))
    assert html_response(conn, 302)
    assert conn.halted
  end

  test "connected mount of /settings/repos/:orga_id when logged out", %{conn: conn} do
    assert {:error, %{redirect: %{to: "/"}}} =
             live(conn, Routes.live_path(conn, AdoptopossWeb.RepoLive, "orga"))
  end

  @tag login_as: "user123"
  test "disconnected mount of /settings/repos/:orga_id when logged in", %{conn: conn, user: user} do
    conn = get(conn, Routes.live_path(conn, AdoptopossWeb.RepoLive, user.username))
    assert html_response(conn, 200) =~ "Submit Repo from"
  end

  @tag login_as: "user123"
  test "connected mount of /settings/repos/:orga_id when logged in", %{conn: conn, user: user} do
    {:ok, _view, html} = live(conn, Routes.live_path(conn, AdoptopossWeb.RepoLive, user.username))
    assert html =~ "Submit Repo from"
  end

  @tag login_as: "user123"
  test "submitting a repo", %{conn: conn, user: user} do
    {:ok, {_page_info, [repo | _] = repos}} = Adoptoposs.Network.user_repos("token", "github", 2)
    tags = repos |> Enum.uniq_by(& &1.language.name) |> Enum.map(& &1.language)

    for tag <- tags do
      insert(:tag, type: Tag.Language.type(), name: tag.name)
    end

    {:ok, view, html} = live(conn, Routes.live_path(conn, AdoptopossWeb.RepoLive, user.username))

    for repo <- repos do
      assert html =~ repo.name
    end

    refute html =~ ~r/submitted to.+your projects/i

    component = [view, "repo-" <> AdoptopossWeb.RepoView.hashed(repo.id)]
    html = render_click(component, :attempt_submit, %{})
    assert html =~ "I’m looking for"
    assert html =~ "Submit"

    html = render_submit(component, :submit_project, %{project: %{description: "text"}})
    assert html =~ ~r/submitted to.+your projects/is
  end
end
