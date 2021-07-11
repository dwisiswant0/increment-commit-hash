# increment-commit-hash

Auto replaces commit hash prefix incrementally with lucky-commit by hooking post-commit.

![increment-commit-hash](https://user-images.githubusercontent.com/25837540/125177531-cb189880-e206-11eb-8239-d0c13b35bb93.png)

> See all demonstrations in this repository's [commit history](https://github.com/dwisiswant0/increment-commit-hash/commits/master).

## Installation

In order for this scenario to work, [lucky_commit](https://github.com/not-an-aardvark/lucky-commit) is required to be installed on your machine.

### Local

To set up automatically in your local project:

```bash
$ curl -sL https://github.com/dwisiswant0/increment-commit-hash/raw/master/setup.sh | sh
```

This will add a post-commit hook for your git project. So every time you commit something, `lucky_commit` will run after it.

### Global

Global means it applies to all your git projects and to install it you have to do-it-yourself (DIY) manually.

Add a Bash function for `git` alias command inside your `.bash_aliases` file:

```bash
git() {
	command git "${@}"
	[[ "${?}" -eq 0 ]] || return

	local COUNT=$(command git rev-list HEAD --count 2>/dev/null)
	local HASH=$(printf "%07d" "${COUNT}")

	[[ "${1}" == "commit" ]] && lucky_commit "${HASH}"
}
```

For the alias to trigger when you run `git` command, you need to either restart the terminal or evaluate directly with:

```bash
$ source $HOME/.bash_aliases
```

After that, the `lucky_commit` command will be executed in any git project after git `commit` subcommand w/o having to add post-commit hooks in your projects 1-by-1.

**Uninstalling**

To delete that alias, simply remove those `git` function from `.bash_aliases` file and restart your terminal session or unaliasing with:

```bash
$ unalias git
```