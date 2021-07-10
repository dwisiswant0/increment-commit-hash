# increment-commit-hash

Auto replaces commit hash prefix incrementally with lucky-commit by hooking post-commit.

![increment-commit-hash](https://user-images.githubusercontent.com/25837540/125177531-cb189880-e206-11eb-8239-d0c13b35bb93.png)

## Installation

In order for this scenario to work, [lucky_commit](https://github.com/not-an-aardvark/lucky-commit) is required to be installed on your machine.

### Local

To set up automatically in your local project:

```bash
$ curl -sL https://github.com/dwisiswant0/increment-commit-hash/raw/master/setup.sh | sh
```

This will add a post-commit hook for your git project. So every time you commit something, `lucky_commit` will run after it.

### Global

Global means it applies to all your git projects and to install it you have to do-it-yourself (DIY) and of course at your own risk too!

Add alias for `git` command inside your `.bash_aliases` file:

```bash
git() {
	command git "${@}"
	local STAT="${?}"

	[[ "${STAT}" -eq 0 ]] || return

	local COUNT=$(command git rev-list HEAD --count 2>/dev/null)
	local HASH=$(printf "%07d" "${COUNT}")

	[[ "${1}" == "commit" ]] && lucky_commit "${HASH}"
}
```

In order for the alias to be triggered when you run a `git` command, you need to restart the terminal or evaluate directly with `source $HOME/.bash_aliases` command.

After that, the `lucky_commit` command will run in any git project w/o having to add post-commit hooks in your projects 1-by-1.