#!/bin/sh -e
# Sync Git repositories from a list file
# Usage: sync_git.sh [LIST_FILE] [GIT_CMD]

DEFAULT_LIST="$(cd "$(dirname "${0}")" && pwd)/repositories.txt"
DEFAULT_GIT="git"
LIST_FILE="${1:-${DEFAULT_LIST}}"
GIT_CMD="${2:-${DEFAULT_GIT}}"

# Validate prerequisites
[ -f "${LIST_FILE}" ] || { echo "Error: List file '${LIST_FILE}' does not exist" >&2; exit 1; }
base_dir="$(cd "$(dirname "${LIST_FILE}")" && pwd)"
[ -w "${base_dir}" ] || { echo "Error: Base directory '${base_dir}' is not writable" >&2; exit 1; }
command -v "${GIT_CMD}" > /dev/null 2>&1 || { echo "Error: Git command '${GIT_CMD}' not found" >&2; exit 1; }
curl -Ism 5 https://github.com/ > /dev/null 2>&1 || { echo "Error: No Internet connection" >&2; exit 1; }

# Process each Git repository
while IFS= read -r url || [ -n "${url}" ]; do
    # Skip invalid repository URLs
    expr "${url}" : 'https://[^[:space:]]\+$' > /dev/null 2>&1 || continue

    # Prepare the repository path
    url="${url%.git}"
    repo_path="${base_dir}/${url#https://}"

    if [ -d "${repo_path}/.git" ]; then
        # Update the existing repository
        cd "${repo_path}"
        "${GIT_CMD}" stash -q && "${GIT_CMD}" pull -q && "${GIT_CMD}" stash pop -q > /dev/null 2>&1 || continue
    elif [ -d "${repo_path}" ] && [ -n "$(ls -A "${repo_path}" 2> /dev/null)" ]; then
        # Skip if the directory exists but is not empty and is not a valid Git repository
        echo "Error: Directory '${repo_path}' exists but is not empty and is not a valid Git repository" >&2
        continue
    else
        # Clone the repository
        mkdir -p "$(dirname "${repo_path}")" && "${GIT_CMD}" clone -q "${url}" "${repo_path}" || continue
    fi

done < "${LIST_FILE}"
