if type jenv >/dev/null; then
  export JENV_ROOT="${JENV_ROOT:=${HOME}/.jenv}"
  export PATH="${JENV_ROOT}/bin:${JENV_ROOT}/shims:${PATH}"
  function load_jenv() {
    eval "$(command jenv init - --no-rehash)"
  }
  async_start_worker jenv_worker -n
  async_register_callback jenv_worker load_jenv
  async_job jenv_worker sleep 0.1
fi
