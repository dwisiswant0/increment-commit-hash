LUCK="lucky_commit"
REPO="increment-commit-hash"

PRE_R="\033[0;31m[${REPO}]\033[0m"
PRE_G="\033[0;32m[${REPO}]\033[0m"
PRE_Y="\033[0;33m[${REPO}]\033[0m"

[[ ! -d ".git/hooks" ]] && { echo -e "${PRE_G} Creating hooks folder..."; mkdir -p .git/hooks; }

echo -e "${PRE_G} Download post-commit script..."
curl -L "https://raw.githubusercontent.com/dwisiswant0/${REPO}/master/post-commit.sh" > .git/hooks/post-commit
[[ $? -eq 0 ]] || { echo -e "${PRE_R} Unable to download post-commit script!"; exit 1; }

echo -e "${PRE_G} Change hooks folder & post-commit file mode bits..."
chmod 755 .git/hooks && chmod ogu+rx .git/hooks/post-commit
[[ $? -eq 0 ]] || { echo -e "${PRE_R} Can't change mode bits!"; exit 1; }

if [[ ! -x "$(command -v "${LUCK}")" ]]; then
	echo -en "${PRE_Y} ${LUCK} not found! "

	if [[ -x "$(command -v "cargo")" ]]; then
		echo "Installing..."
		eval "cargo install ${LUCK} --locked"
	else
		echo -e "\n"
		echo -e "${PRE_R} Rust package manager not installed! See https://www.rust-lang.org/tools/install."
		exit 1
	fi
fi

echo -e "${PRE_G} Setup finished!"