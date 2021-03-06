;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(nginx
     windows-scripts
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------

     ;; Turn on lsp layer, which should be used automatically by supported languages
     (lsp :variables
          lsp-ui-doc-enable t)
     dap

     ;; Languages
     ansible
     cb-groovy
     csv
     docker
     emacs-lisp
     go
     html
     javascript
     markdown
     (python :variables
             python-backend 'lsp
             python-lsp-server 'mspyls
             python-fill-column 120
             python-tab-width 4
             python-formatter 'yapf
             python-pipenv-activate t
             python-shell-completion-native-enable nil
             python-lsp-git-root "~/dev/python-language-server"
             ;; python-format-on-save t
             ;; python-sort-imports-on-save t
             python-test-runner 'pytest
             pytest-global-name "pipenv run python -m pytest -v")
     ;; react
     ruby
     ;; rust
     ;; salt
     shell-scripts
     terraform
     ;; toml
     typescript
     (yaml :variables
           yaml-enable-lsp t)

     ;; Finance
     ;; beancount
     ;; finance

     ;; Helpers
     better-defaults
     evil-commentary
     ;; Disabling gtags in favor of using dumb-jump
     ;; gtags
     helm
     treemacs
     multiple-cursors
     osx
     (evil-snipe :variables
                 evil-snipe-enable-alternate-f-and-t-behaviors t)

     ;; Version control
     git
     (version-control :variables
                      version-control-global-margin t
                      version-control-diff-side 'left
                      version-control-diff-tool 'git-gutter)

     ;; Syntax / Linting / Auto complete
     syntax-checking
     (spell-checking :variables
                     enable-flyspell-auto-completion t
                     spell-checking-enable-by-default nil)
     ;; company
     (auto-completion :disabled-for markdown
                      :variables
                      auto-completion-enable-help-tooltip t
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-return-key-behavior 'complete
                      auto-completion-enable-sort-by-usage t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-idle-delay 0.2
                      auto-completion-private-snippets-directory "~/.spacemacs.d/snippets/")

     ;; Org and misc
     (org :variables
          org-enable-github-support t
          org-enable-hugo-support t
          org-enable-trello-support t
          org-enable-reveal-js-support t
          org-startup-indented nil
          org-adapt-indentation nil)
     deft
     confluence

     ;; Shell / Terminals
     (shell :variables
            shell-default-shell 'ansi-term
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-term-shell "/bin/zsh")
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(company-terraform
                                      company-quickhelp
                                      company-lsp
                                      exec-path-from-shell
                                      editorconfig
                                      org-mru-clock
                                      keychain-environment
                                      )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 14
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but lines are only visual lines are counted. For example, folded lines
   ;; will not be counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun my-setup-indent (n)
  ;; taken from https://stackoverflow.com/questions/36719386/spacemacs-set-tab-width
  ;; java/c/c++
  (setq c-basic-offset n)
  ;; web development
  (setq coffee-tab-width n) ; coffeescript
  (setq javascript-indent-level n) ; javascript-mode
  (setq js-indent-level n) ; js-mode
  (setq js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
  (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq css-indent-offset n) ; css-mode
  )

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put almost
any user code here.  The exception is org related code, which should be placed
in `dotspacemacs/user-config'."
  (setq-default
   ;; Indent javascript and json by 2 spaces instead of 4
   js2-basic-offset 2
   js-indent-level 2
   ;; Other tab-related settings
   tab-width 2
   evil-shift-width 2
   python-indent-offset 2
   )
  ;; Indent everything by 2 spaces by default instead of 4
  (my-setup-indent 2)
  )


;; From https://blog.aaronbieber.com/2016/09/24/an-agenda-for-life-with-org-mode.html
(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
        subtree-end
      nil)))

;; Also from above link, but do I really want to filter out habits?
(defun air-org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
        subtree-end
      nil)))

;; From https://gitlab.com/howardabrams/spacemacs.d/blob/master/layers/ha-org/funcs.el#L352
(defun ha/org-capture-code-snippet (f)
  "Given a file, F, this captures the currently selected text
within an Org SRC block with a language based on the current mode
and a backlink to the function and the file."
  (with-current-buffer (find-buffer-visiting f)
    (let ((org-src-mode (replace-regexp-in-string "-mode" "" (format "%s" major-mode)))
          (func-name (which-function)))
      (ha/org-capture-fileref-snippet f "SRC" org-src-mode func-name))))

(defun ha/org-capture-clip-snippet (f)
  "Given a file, F, this captures the currently selected text
within an Org EXAMPLE block and a backlink to the file."
  (with-current-buffer (find-buffer-visiting f)
    (ha/org-capture-fileref-snippet f "EXAMPLE" "" nil)))

(defun ha/org-capture-fileref-snippet (f type headers func-name)
  (let* ((code-snippet
          (buffer-substring-no-properties (mark) (- (point) 1)))
         (file-name   (buffer-file-name))
         (file-base   (file-name-nondirectory file-name))
         (line-number (line-number-at-pos (region-beginning)))
         (initial-txt (if (null func-name)
                          (format "From [[file:%s::%s][%s]]:"
                                  file-name line-number file-base)
                        (format "From ~%s~ (in [[file:%s::%s][%s]]):"
                                func-name file-name line-number
                                file-base))))
    (format "
%s

#+BEGIN_%s %s
%s
#+END_%s" initial-txt type headers code-snippet type)))

(defun ha/code-to-clock (&optional start end)
  "Send the currently selected code to the currently clocked-in org-mode task."
  (interactive)
  (org-capture nil "F"))

(defun ha/code-comment-to-clock (&optional start end)
  "Send the currently selected code (with comments) to the
currently clocked-in org-mode task."
  (interactive)
  (org-capture nil "f"))

;; Helpful clock functions from http://doc.norang.ca/org-mode.html#Clocking
(defun bh/clock-in-to-next (kw)
  "Switch a task from TODO to IN-PROGRESS when clocking in.
Skips capture tasks, projects, and subprojects.
Switch projects and subprojects from IN-PROGRESS back to TODO"
  (when (not (and (boundp 'org-capture-mode) org-capture-mode))
    (cond
     ((and (member (org-get-todo-state) (list "TODO"))
           (bh/is-task-p))
      "IN-PROGRESS")
     ((and (member (org-get-todo-state) (list "IN-PROGRESS"))
           (bh/is-project-p))
      "TODO"))))

(defun bh/find-project-task ()
  "Move point to the parent (project) task if any"
  (save-restriction
    (widen)
    (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
      (while (org-up-heading-safe)
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq parent-task (point))))
      (goto-char parent-task)
      parent-task)))

(defun bh/punch-in (arg)
  "Start continuous clocking and set the default task to the
selected task.  If no task is selected set the Organization task
as the default task."
  (interactive "p")
  (setq bh/keep-clock-running t)
  (if (equal major-mode 'org-agenda-mode)
      ;;
      ;; We're in the agenda
      ;;
      (let* ((marker (org-get-at-bol 'org-hd-marker))
             (tags (org-with-point-at marker (org-get-tags-at))))
        (if (and (eq arg 4) tags)
            (org-agenda-clock-in '(16))
          (bh/clock-in-organization-task-as-default)))
    ;;
    ;; We are not in the agenda
    ;;
    (save-restriction
      (widen)
      ; Find the tags on the current task
      (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
          (org-clock-in '(16))
        (bh/clock-in-organization-task-as-default)))))

(defun bh/punch-out ()
  (interactive)
  (setq bh/keep-clock-running nil)
  (when (org-clock-is-active)
    (org-clock-out))
  (org-agenda-remove-restriction-lock))

(defun bh/clock-in-default-task ()
  (save-excursion
    (org-with-point-at org-clock-default-task
      (org-clock-in))))

(defun bh/clock-in-parent-task ()
  "Move point to the parent (project) task if any and clock in"
  (let ((parent-task))
    (save-excursion
      (save-restriction
        (widen)
        (while (and (not parent-task) (org-up-heading-safe))
          (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
            (setq parent-task (point))))
        (if parent-task
            (org-with-point-at parent-task
              (org-clock-in))
          (when bh/keep-clock-running
            (bh/clock-in-default-task)))))))

(defvar bh/organization-task-id "EE4C523B-574F-4C5B-B270-9B3A340B7514")

(defun bh/clock-in-organization-task-as-default ()
  (interactive)
  (org-with-point-at (org-id-find bh/organization-task-id 'marker)
    (org-clock-in '(16))))

(defun bh/clock-out-maybe ()
  (when (and bh/keep-clock-running
             (not org-clock-clocking-in)
             (marker-buffer org-clock-default-task)
             (not org-clock-resolving-clocks-due-to-idleness))
    (bh/clock-in-parent-task)))

;; From https://gist.github.com/ironchicken/6b5424bc2024b3d0a58a8a130f73c2ee and
;; https://emacs.stackexchange.com/questions/32178/how-to-create-table-of-time-distribution-by-tags-in-org-mode
(defun clocktable-by-tag/shift-cell (n)
  (let ((str ""))
    (dotimes (i n)
      (setq str (concat str "| ")))
    str))

(defun clocktable-by-tag/insert-tag (params)
  (let ((tag (plist-get params :tags)))
    (insert "|--\n")
    (insert (format "| %s | *Tag time* |\n" tag))
    (let ((total 0))
      (mapcar
       (lambda (file)
         (let ((clock-data (with-current-buffer (find-file-noselect file)
                             (org-clock-get-table-data (buffer-name) params))))
           (when (> (nth 1 clock-data) 0)
             (setq total (+ total (nth 1 clock-data)))
             (insert (format "| | File *%s* | %.2f |\n"
                             (file-name-nondirectory file)
                             (/ (nth 1 clock-data) 60.0)))
             (dolist (entry (nth 2 clock-data))
               (insert (format "| | . %s%s | %s %.2f |\n"
                               (org-clocktable-indent-string (nth 0 entry))
                               (nth 1 entry)
                               (clocktable-by-tag/shift-cell (nth 0 entry))
                               (/ (nth 4 entry) 60.0)))))))
       (org-agenda-files))
      (save-excursion
        (re-search-backward "*Tag time*")
        (org-table-next-field)
        (org-table-blank-field)
        (insert (format "*%.2f*" (/ total 60.0)))))
    (org-table-align)))

(defun org-dblock-write:clocktable-by-tag (params)
  (insert "| Tag | Headline | Time (h) |\n")
  (insert "|     |          | <r>  |\n")
  (let ((tags (plist-get params :tags)))
    (mapcar (lambda (tag)
              (clocktable-by-tag/insert-tag (plist-put (plist-put params :match tag) :tags tag)))
            tags)))

;; From https://emacs.stackexchange.com/questions/9502/category-based-clock-report
(defun private/clocktable-formatter-group-by-prop (ipos tables params)
  (let* ((formatter (or org-clock-clocktable-formatter
                        'org-clocktable-write-default))
         (ht (make-hash-table :test 'equal))
         (total 0)
         (grouped
          (dolist (tt tables (sort (hash-table-keys ht)
                                   #'(lambda (x y) (string< x y))))
            (setq total (+ total (nth 1 tt)))
            (dolist (record (nth 2 tt))
              (let* ((lasttwo (last record 2))
                     (time (pop lasttwo))
                     (prop (cdr (car (car lasttwo))))
                     (prev (gethash prop ht 0)))
                (puthash prop (+ prev time) ht))
              ))
          )
         (newtable (mapcar (lambda (arg) (list 1 arg nil nil (gethash arg ht) nil)) grouped))
         (new-params (org-plist-delete params :properties)))
    (funcall formatter ipos (list (list nil total newtable)) new-params)))

; TODO: This doesn't work. because I don't know how to lisp
(defun justyn/clock-in-recent-tasks ()
  (interactive)
  (setq current-prefix-arg 4)
  ; (universal-argument)
  (org-clock-in))

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  ; Resize default window
  (add-to-list 'default-frame-alist '(height . 42))
  (add-to-list 'default-frame-alist '(width . 160))

  (setq org-mru-clock-how-many 50)
  (setq org-clock-persist t)
  (org-clock-persistence-insinuate)
  (setq org-enable-github-support t)
  (setq rst-pdf-program "/Applications/Preview.app/Contents/MacOS/Preview")
  (setq magit-repository-directories '("~/dev/"))
  (setq org-agenda-files (quote ("~/org/")))
  (setq org-refile-targets '((org-agenda-files . (:maxlevel . 3))))
  (setq org-capture-templates
        ;; TODO: Move some of these to a separate file not in git, since I don't need them in every computer
        '(("t" "Todo" entry (file+headline "~/org/TODO.org" "Tasks")
           "* TODO %?\nCREATED: %U\n%i\n%a")
          ("T" "Todo with Clipboard" entry (file+headline "~/org/TODO.org" "Tasks")
           "* TODO %?\nCREATED: %U\n%c"
           :empty-lines 1)
          ("r" "Read Later" entry (file+headline "~/org/TODO.org" "Read Later")
           "* TODO %?  :readlater:\nCREATED: %U")
          ("j" "Journal"
           entry (file+datetree "~/org/journal.org")
           "* %? \nCREATED: %U\n%i\n%a"
           :empty-lines 1)
          ;; TODO: Use year in filename automatically
          ("w" "New WorkLog entry"
           entry (file+datetree "~/org/worklog_2020.org")
           "* %? :work:\nCREATED: %T\n%i\n%a\n"
           :clock-in t
           :clock-resume t
           :empty-lines 1)
          ("W" "New Work Ticket"
           entry (file+datetree "~/org/worklog_2020.org")
           "* IN-PROGRESS %^{TicketID}: %^{Title} :work:ticket:
:PROPERTIES:
:ID: %\\1
:BI_ENVIRONMENT: %^{BI_ENVIRONMENT}
:BI_CUSTOMER: %^{BI_CUSTOMER}
:CREATED: %T
:END:\n%?"
           :clock-in t
           :clock-resume t
           :empty-lines 1)
          ("n" "Append timestamped note to clocked task"
           plain (clock)
           "%U %?"
           :empty-lines 1)
          ("m" "Meeting"
           entry (file+datetree "~/org/worklog_2020.org")
           "* Meeting for %^{Title} :work:meeting:\nCREATED: %T\nAgenda/Purpose: \nWho: \n\n - %?\n"
           :empty-lines 1
           :clock-in t
           :clock-resume t)
          ("M" "Adhoc Meeting(Chat/InPerson/Email/Etc)"
           entry (file+datetree "~/org/worklog_2020.org")
           "* Adhoc meeting w/ %^{Who} about %^{What} :work:meeting:\nCREATED: %T\nWho: %\\1 \nNotes: %?\n"
           :empty-lines 1
           :clock-in t
           :clock-resume t)
          ("f" "Todo - Follow-up later today on e-mail/slack/etc"
           entry (file+datetree "~/org/worklog_2020.org")
           "* NEXT [#A] %? :work:followup:\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\")) CREATED: %T\n"
           :empty-lines 1)
          ("v" "Code Reference with Comments to Current Task"
           plain (clock)
           "%?\n%(ha/org-capture-code-snippet \"%F\")\n\n"
           :empty-lines 1)
          ("V" "Link to Code Reference to Current Task"
           plain (clock)
           "%(ha/org-capture-code-snippet \"%F\")"
           :empty-lines 1 :immediate-finish t)
          ))
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "IN-PROGRESS(i!)" "|" "DONE(d!)")
          (sequence "WAITING(w@/!)" "BLOCKED(b@/!)" "|" "CANCELLED(c@/!)")))
  ;; Borrowed from https://blog.aaronbieber.com/2016/09/24/an-agenda-for-life-with-org-mode.html
  (setq org-agenda-custom-commands
        '(("d" "Daily agenda and all TODOs"
           ((agenda "" ((org-agenda-span 2)))
            (todo "IN-PROGRESS"
                  ((org-agenda-overriding-header "In-Progress tasks:")))
            (tags "PRIORITY=\"A\""
                  ((org-agenda-skip-function '(or (org-agenda-skip-entry-if 'todo 'done)
                                                  (org-agenda-skip-entry-if 'todo '("IN-PROGRESS"))))
                   (org-agenda-overriding-header "High-priority unfinished tasks:")))
            (todo "NEXT"
                  ((org-agenda-skip-function '(or (air-org-skip-subtree-if-priority ?A)))
                   (org-agenda-overriding-header "NEXT tasks: ")))
            (todo "WAITING|BLOCKED"
                  ((org-agenda-skip-function '(or (air-org-skip-subtree-if-priority ?A)))
                   (org-agenda-overriding-header "WAITING/BLOCKED tasks:")))
            ;; TODO: Figure out how to exclude readlater tag
            (alltodo ""
                     ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
                                                     (air-org-skip-subtree-if-priority ?A)
                                                     (org-agenda-skip-entry-if 'todo '("NEXT" "IN-PROGRESS" "WAITING" "BLOCKED"))
                                                     (org-agenda-skip-if nil '(scheduled deadline))))
                      (org-agenda-overriding-header "ALL normal priority tasks:"))))
           ((org-agenda-compact-blocks t)))
          ("n" todo "NEXT")
          ("w" todo "BLOCKED|WAITING")
          ("i" todo "IN-PROGRESS")
          ))
  ;; org-clock settings
  (setq bh/keep-clock-running nil)
  (add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)
  ;; Enable org-clock in modeline
  (setq spaceline-org-clock-p t)
  ;; Delete clocks that are 0:00
  (setq org-clock-out-remove-zero-time-clocks t)
  ;; Include current task in clock report
  (setq org-clock-report-include-clocking-task t)
  ;; Store clock history for longer
  (setq org-clock-history-length 15)
  ;; Clock report default params
  (setq org-agenda-clockreport-parameter-plist
        (quote (:link t :maxlevel 3 :fileskip0 t :compact t :narrow 100)))
  ;; Default Column View
  (setq org-columns-default-format "%5TODO %30ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM(Clocked) %3PRIORITY(PRI) %TAGS")
  ;; Enable org-habit org module
  (add-to-list 'org-modules 'org-habit t)
  ;; Enable org-expiry org module
  (add-to-list 'org-modules 'org-expiry t)
  (org-expiry-insinuate)
  (setq org-expiry-created-property-name "CREATED"
        org-expiry-inactive-timestamps t)
  ;; Enable speed commands for single-key commands at the beginning of headers.  ? for help  TODO: I don't really know what these do
  (setq org-use-speed-commands t)
  ;; Prettier code blocks
  (setq org-src-fontify-natively t)
  ;; Hide code blocks by default in org-mode
  '(org-hide-block-startup t)
  ;; Don't indent subheadings in org-mode files.  Everything should be flush left
  ;; These are set in the org layer vars above
  ;; (setq org-adapt-indentation nil)
  ;; (setq org-indent-mode nil)
  ;; (setq org-startup-indented nil)

  ;; Disable tag inheritence to speed up agenda rendering
  (setq org-agenda-use-tag-inheritance nil)
  ;; Disable dim blocked tasks to speed up agenda rendering
  (setq org-agenda-dim-blocked-tasks nil)
  ;; Don't prepare agenda buffers on startup
  (setq org-agenda-inhibit-startup t)
  ;; Don't kill agenda buffers, just hide them
  (setq org-agenda-sticky t)
  ;; Disable processing some org drawer properties to speed up the agenda rendering
  (setq org-agenda-ignore-drawer-properties '(effort appt category))

  ;; From https://emacs.stackexchange.com/questions/804/how-do-i-speed-up-org-mode-agenda-generation
  ;; Pregenerates the agenda buffer whenever emacs is idle
  ;; TODO: This kind of works, but it deletes the window and also doesn't refresh it because of the org-agenda-sticky thing?
  (run-with-idle-timer 300 nil (lambda () (org-agenda-list) (delete-window)))

  (setq-default org-download-image-dir "./img/")
  ;; I couldn't get imagemagick/convert to work on MacOS, so this uses pngpaste.  It's not going to work
  ;; on Windows.  TODO: I also don't know why I can paste an image into an open buffer using cmd+v and it shows up,
  ;; but nothing saves that image to disk.
  ;; pngpaste (https://github.com/jcsalterego/pngpaste) can be installed with: brew install pngpaste
  (setq org-download-screenshot-method "pngpaste %s")

  ;; Shortcuts for org-structure templates (the +BEGIN_SRC type blocks)
  ;; This can be accessed by pressing C-c C-,
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("sh" . "src bash"))
  (add-to-list 'org-structure-template-alist '("y" . "src yaml"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))

  ;; Deft settings
  (setq deft-extensions '("org" "md" "txt"))
  (setq deft-default-extension "org")
  (setq deft-text-mode 'org-mode)
  ;; I created symlinks in ~/.deft pointing to my org notes/joplin/etc
  (setq deft-directory "~/.deft")
  (setq deft-recursive t)
  ;; TODO: Figure out how to make this work with stuff like Joplin's markdown format
  ;; See https://jingsi.space/post/2017/04/05/organizing-a-complex-directory-for-emacs-org-mode-and-deft/
  (setq deft-use-filename-as-title nil)
  (setq deft-use-filter-string-for-filename t)
  (setq deft-file-naming-rules '((nospace . "-")
                                 (case-fn . downcase)))
  ;; Limit the number of files Deft shows by default to speed it up
  (setq deft-file-limit 100)
  ;; Map Ctrl+p to helm-projectile-find-file like the vim plugin
  (define-key evil-normal-state-map (kbd "C-p") 'helm-projectile-find-file)
  ;; Map Super-/ to toggle comments (like most IDEs)
  (define-key evil-normal-state-map (kbd "S-/") 'evil-commentary)
  ;; Enable company for autocomplete and get it working for terraform+quickhelp
  (global-company-mode t)
  (company-terraform-init)
  ;; Copy ssh-agent vars into emacs so magit can work
  (exec-path-from-shell-copy-env "SSH_AGENT_PID")
  (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")
  ;; Set fill-column and turn on autowrap in text modes like org/markdown
  (setq-default fill-column 120)
  (add-hook 'text-mode-hook 'auto-fill-mode)
  ;; Show 80-column marker
  ;; (define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
  ;; (global-fci-mode 1)
  (turn-on-fci-mode)
  ;; Use /sshx because /ssh doesn't seem to work on bsd, and some of my
  ;; remote shells don't use sh/bash.  ssh/sshx should also be faster than scp
  (setq tramp-default-method "sshx")

  ;; Use my default ctags configuration which excludes a lot of things we don't want
  (setq projectile-tags-command "ctags --options=~/.ctags -Re -f \"%s\" %s \"%s\"")

  ;; Python settings
  ;; Activate pipenv venv automatically
  ;; Moved to layer config
  ;; (setq python-pipenv-activate t)
  ;; Mostly from https://mostlymaths.net/2019/05/lsp-for-python-and-scala.html/

  ;; TODO: I'm not sure if I need to use use-package, or if I can put this in the layer config above
  ;; This is the main mode for LSP
  (use-package lsp-mode
    :init (setq lsp-prefer-flymake nil)
    :ensure t)
  ;; This makes imenu-lsp-minor-mode available. This minor mode
  ;; will show a table of contents of methods, classes, variables.
  ;; You can configure it to be on the left by using `configure`
  (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)
  ;; lsp-ui enables the fancy showing of documentation, error
  ;; messages and type hints
  (use-package lsp-ui
    :ensure t
    :config
    (setq lsp-ui-sideline-ignore-duplicate t)
    (add-hook 'lsp-mode-hook 'lsp-ui-mode))
  ;; company is the best autocompletion system for emacs (probably)
  ;; and this uses the language server to provide semantic completions
  (use-package company-lsp
    :commands company-lsp
    :config
    (push 'company-lsp company-backends))
  (use-package flycheck
    :init (global-flycheck-mode))
  (defun lsp-set-cfg ()
    (let ((lsp-cfg `(:pyls (:configurationSources ("flake8")))))
      (lsp--set-configuration lsp-cfg)))
  (add-hook 'lsp-after-initialize-hook 'lsp-set-cfg)

  ;; Alias [ and ] to all types of brackets
  ;; With this, I can use evil-snipe by pressing f and then [ and it will search for any of these types of brackets
  (push '(?\[ "[[{(]") evil-snipe-aliases)
  (push '(?\] "[]})]") evil-snipe-aliases)

  ;; Custom keymaps
  (spacemacs/declare-prefix "o" "custom")
  (spacemacs/set-leader-keys "op" 'bh/punch-in)
  (spacemacs/set-leader-keys "oP" 'bh/punch-out)
  (spacemacs/set-leader-keys "oC" 'calculator)
  ; (spacemacs/set-leader-keys "oc" 'justyn/clock-in-recent-tasks)
  (spacemacs/set-leader-keys "oc" 'org-mru-clock-in)
  (spacemacs/set-leader-keys "os" 'org-save-all-org-buffers)
  (spacemacs/set-leader-keys "oq" 'auto-fill-mode)

  ;; Remap space q q to kill frame instead of emacs (to keep emacs server alive)
  ;; Disabled - Just use space q f
  ;; (evil-leader/set-key "q q" 'spacemacs/frame-killer)

  (setq dotspacemacs-auto-resume-layouts t)
  (setq dotspacemacs-enable-paste-transient-state t)
  (setq dotspacemacs-whitespace-cleanup 'all)

  ;; Source ssh-agent from keychain
  (keychain-refresh-environment)

  ;; Start Emacs server
  (unless (server-running-p)
    (server-start))

  ;; Layout settings
  (setq dotspacemacs-display-default-layout t)

  ;; Save backups in one place
  (setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

  ;; Disable lock files
  (setq create-lockfiles nil)

  ;; Try to prevent emacs from using 100% cpu due to autosave
  ;; See https://github.com/syl20bnr/spacemacs/issues/9409
  (setq history-length 250)
  (put 'minibuffer-history 'history-length 50)
  (put 'evil-ex-history 'history-length 50)
  (put 'kill-ring 'history-length 25)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (spinner iedit anzu evil undo-tree powerline smartparens pcre2el org-category-capture alert log4e gntp markdown-mode parent-mode projectile pkg-info epl flx highlight git-commit with-editor goto-chg json-mode tablist magit-popup docker-tramp json-snatcher json-reformat terraform-mode hcl-mode dash-functional pos-tip inf-ruby bind-map bind-key yasnippet packed anaconda-mode pythonic f dash s async auto-complete popup go-mode company helm helm-core avy org-plus-contrib hydra lv flycheck typescript-mode skewer-mode simple-httpd multiple-cursors js2-mode haml-mode fringe-helper git-gutter+ git-gutter flyspell-correct web-completion-data tern smeargle orgit magit-gitflow helm-gitignore gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link evil-magit magit transient yapfify yaml-mode xterm-color ws-butler winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package unfill toc-org tide tagedit spaceline slim-mode shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe reveal-in-osx-finder restart-emacs request rbenv rake rainbow-delimiters pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements persp-mode pbcopy paradox ox-reveal ox-gfm osx-trash osx-dictionary org-projectile org-present org-pomodoro org-mime org-download org-bullets open-junk-file neotree mwim multi-term move-text mmm-mode minitest markdown-toc macrostep lorem-ipsum livid-mode live-py-mode linum-relative link-hint ledger-mode launchctl js2-refactor js-doc insert-shebang indent-guide hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag groovy-mode google-translate golden-ratio go-guru go-eldoc gnuplot git-gutter-fringe git-gutter-fringe+ gh-md fuzzy flyspell-popup flyspell-correct-helm flycheck-pos-tip flycheck-ledger flx-ido fish-mode fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-commentary evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help emmet-mode elisp-slime-nav dumb-jump dockerfile-mode docker diminish diff-hl cython-mode company-web company-terraform company-tern company-statistics company-shell company-quickhelp company-go company-anaconda column-enforce-mode coffee-mode clean-aindent-mode chruby bundler auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-hide-block-startup t)
 '(org-trello-current-prefix-keybinding "C-c o" nil (org-trello))
 '(package-selected-packages
   (quote
    (keychain-environment spinner iedit anzu evil undo-tree powerline smartparens pcre2el org-category-capture alert log4e gntp markdown-mode parent-mode projectile pkg-info epl flx highlight git-commit with-editor goto-chg json-mode tablist magit-popup docker-tramp json-snatcher json-reformat terraform-mode hcl-mode dash-functional pos-tip inf-ruby bind-map bind-key yasnippet packed anaconda-mode pythonic f dash s async auto-complete popup go-mode company helm helm-core avy org-plus-contrib hydra lv flycheck typescript-mode skewer-mode simple-httpd multiple-cursors js2-mode haml-mode fringe-helper git-gutter+ git-gutter flyspell-correct web-completion-data tern smeargle orgit magit-gitflow helm-gitignore gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link evil-magit magit transient yapfify yaml-mode xterm-color ws-butler winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package unfill toc-org tide tagedit spaceline slim-mode shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe reveal-in-osx-finder restart-emacs request rbenv rake rainbow-delimiters pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements persp-mode pbcopy paradox ox-reveal ox-gfm osx-trash osx-dictionary org-projectile org-present org-pomodoro org-mime org-download org-bullets open-junk-file neotree mwim multi-term move-text mmm-mode minitest markdown-toc macrostep lorem-ipsum livid-mode live-py-mode linum-relative link-hint ledger-mode launchctl js2-refactor js-doc insert-shebang indent-guide hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag groovy-mode google-translate golden-ratio go-guru go-eldoc gnuplot git-gutter-fringe git-gutter-fringe+ gh-md fuzzy flyspell-popup flyspell-correct-helm flycheck-pos-tip flycheck-ledger flx-ido fish-mode fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-commentary evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help emmet-mode elisp-slime-nav dumb-jump dockerfile-mode docker diminish diff-hl cython-mode company-web company-terraform company-tern company-statistics company-shell company-quickhelp company-go company-anaconda column-enforce-mode coffee-mode clean-aindent-mode chruby bundler auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
