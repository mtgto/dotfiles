if type jenv >/dev/null; then
  export JENV_ROOT="${JENV_ROOT:=${HOME}/.jenv}"
  export PATH="${JENV_ROOT}/bin:${JENV_ROOT}/shims:${PATH}"
  eval "$(command jenv init -)"
fi
