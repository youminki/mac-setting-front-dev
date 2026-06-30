# Powerlevel10k 설정 — Dracula 컬러 + 프론트 개발 최적화
# p10k configure 로 언제든 재생성 가능

'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob

  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_CONFIG_FILE'

  autoload -Uz is-at-least && is-at-least 5.1 || return

  # ── Prompt 구성 ─────────────────────────────────────
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    os_icon
    dir
    vcs
    newline
    prompt_char
  )

  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status
    command_execution_time
    node_version
    time
    newline
  )

  # ── 공통 ────────────────────────────────────────────
  typeset -g POWERLEVEL9K_MODE=nerdfont-v3
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR='─'
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND=238

  # ── os_icon ─────────────────────────────────────────
  typeset -g POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION=''
  typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND=236
  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=141   # Dracula purple

  # ── dir ─────────────────────────────────────────────
  typeset -g POWERLEVEL9K_DIR_BACKGROUND=141        # Dracula purple
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=236
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=250
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=255
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=40
  typeset -g POWERLEVEL9K_DIR_HYPERLINK=false

  # ── vcs (git) ───────────────────────────────────────
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=' '

  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=84    # Dracula green
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=236

  typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=215  # Dracula orange
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=236

  typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=212  # Dracula pink
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=236

  typeset -g POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND=203  # Dracula red
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_FOREGROUND=255

  typeset -g POWERLEVEL9K_VCS_LOADING_BACKGROUND=238
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=244

  # ── prompt_char ─────────────────────────────────────
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_FOREGROUND=84    # green: 정상
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VICMD_FOREGROUND=141   # purple: vi 명령모드
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIVIS_FOREGROUND=212   # pink: vi 비주얼
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIOWR_FOREGROUND=215   # orange: vi 오버라이트
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_FOREGROUND=203 # red: 에러
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VICMD_FOREGROUND=203
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIVIS_FOREGROUND=203
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIOWR_FOREGROUND=203
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=false

  # ── status ──────────────────────────────────────────
  typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
  typeset -g POWERLEVEL9K_STATUS_OK=false           # 성공 시 숨김
  typeset -g POWERLEVEL9K_STATUS_ERROR=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=203
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=255
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_BACKGROUND=203
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND=255

  # ── command_execution_time ──────────────────────────
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3    # 3초 이상만 표시
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=1
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=236
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=228  # Dracula yellow

  # ── node_version ────────────────────────────────────
  typeset -g POWERLEVEL9K_NODE_VERSION_PROJECT_ONLY=true        # package.json 있는 폴더에서만
  typeset -g POWERLEVEL9K_NODE_VERSION_BACKGROUND=236
  typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND=84            # Dracula green
  typeset -g POWERLEVEL9K_NODE_ICON=''

  # ── time ────────────────────────────────────────────
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
  typeset -g POWERLEVEL9K_TIME_BACKGROUND=236
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=244
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false

  # ── 세그먼트 공통 padding ────────────────────────────
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=''
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=''

  (( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
  'builtin' 'unset' 'p10k_config_opts'
}
