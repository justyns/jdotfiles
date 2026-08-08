;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Justyn Shull"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq which-key-idle-delay 0.25)

(defun justyn/doom-compile (command)
  "Run doom COMMAND in an async compilation buffer (with ANSI colors)."
  (let ((default-directory doom-user-dir)
        (compilation-buffer-name-function (lambda (&rest _) "*doom*")))
    (compile command)))

(defun justyn/doom-sync ()
  "Run `doom sync'."
  (interactive)
  (justyn/doom-compile "doom sync"))

(defun justyn/doom-sync-and-build ()
  "Run `doom sync && doom build'."
  (interactive)
  (justyn/doom-compile "doom sync && doom build"))

(map! :leader
      (:prefix ("j" . "justyn")
               (:prefix ("d" . "doom")
                        :desc "Doom sync" "s" #'justyn/doom-sync
                        :desc "Doom sync/build" "S" #'justyn/doom-sync-and-build)))

(use-package! powerthesaurus
  :defer t)
(map! :leader
      (:prefix ("j" . "justyn")
               (:prefix ("a" . "applications")
                        :desc "Use powerthesaurus to fetch better word" "p" #'powerthesaurus-lookup-dwim)))

(use-package! string-inflection
  :defer t)
(map! :leader
      (:prefix ("j" . "justyn")
               (:prefix ("a" . "applications")
                        :desc "Cycle through string case using String-inflection" "c" #'string-inflection-all-cycle)))

(if (file-exists-p "~/.doom.local.el")
    (load-file "~/.doom.local.el"))

(setq-default custom-file (expand-file-name ".custom.el" doom-user-dir))
(when (file-exists-p custom-file)
  (load custom-file))

(after! org
  ;; Default Column View
  (setq org-columns-default-format "%5TODO %30ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM(Clocked) %3PRIORITY(PRI) %TAGS")

  ;; Enable speed commands for single-key commands at the beginning of headers.  ? for help  TODO: I don't really know what these do
  (setq org-use-speed-commands t)
  ;; Prettier code blocks
  (setq org-src-fontify-natively t)
  ;; Hide code blocks by default in org-mode
  (setq org-hide-block-startup t)

  ;; Open .org files as folded by default
  (setq org-startup-folded 'overview)
  )

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads, so don't use after!
(setq org-directory "~/org/")

;; Shortcuts for org-structure templates (the +BEGIN_SRC type blocks)
;; This can be accessed by pressing C-c C-,
(after! org
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("sh" . "src bash"))
  (add-to-list 'org-structure-template-alist '("y" . "src yaml"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  )

(after! org
  (setq org-agenda-files (quote ("~/org/" "~/org/journal/")))
  (setq org-refile-targets '((org-agenda-files . (:maxlevel . 3))))

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
  ;; TODO: Do I want this?  It logs status changes into a LOGBOOK drawer instead of just as a list
  (setq org-log-into-drawer t)
  ;; Hide things that are done
  (setq org-agenda-skip-scheduled-if-done t
   org-agenda-skip-deadline-if-done t)
  ;; org-enforce-todo-checkbox-dependencies t
  ;; org-enforce-todo-dependencies t
  )

;; Keywords to use by default in .org files
(after! org
    (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "IN-PROGRESS(i!)" "|" "DONE(d!)")
            (sequence "WAITING(w@/!)" "BLOCKED(b@/!)" "|" "CANCELLED(c@/!)")
            (sequence "[ ](T)" "[-](P)" "[?](M)" "|" "[X](D)"))))

(after! org
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/org/TODO.org" "Tasks")
           "* TODO %?\nCREATED: %U\n%i\n%a")
          ("r" "Read Later" entry (file+headline "~/org/TODO.org" "Read Later")
           "* TODO %?  :readlater:\nCREATED: %U")
          ("j" "Journal"
           entry (file+olp+datetree "~/org/journal.org.gpg")
           "* %? \nCREATED: %U\n%i\n%a"
           :empty-lines 1))))

(setq org-crypt-key "AA5A79D7AD584854")

;; TODO: I'm not sure how to go to a specific window, so this really just goes left and right for now
(map! :leader
      (:desc "Window left" "1" #'evil-window-left
       :desc "Window right" "2" #'evil-window-right))
(map! :leader
      (:prefix ("w" . "window")
               (:desc "Window left" "1" #'evil-window-left
                :desc "Window right" "2" #'evil-window-right
                :desc "evil-window-vsplit" "|" #'evil-window-vsplit
                :desc "evil-window-vsplit" "/" #'evil-window-vsplit)))

;; macOS-style Cmd bindings (Emacs maps the Command key to Meta by default).  On Linux
;; these would clobber standard Alt bindings, so only enable them on macOS.
(when (eq system-type 'darwin)
  (map! "M-a" #'mark-whole-buffer   ; Select all
        "M-s" #'save-buffer         ; Save
        "M-v" #'consult-yank-pop))  ; Paste menu

(map!
 :n "C-h" #'evil-window-left
 :n "C-j" #'evil-window-down
 :n "C-k" #'evil-window-up
 :n "C-l" #'evil-window-right
 )

(map!
 (:map evil-treemacs-state-map
       "C-h" #'evil-window-left
       "C-l" #'evil-window-right)
 )

;; On startup, restore the last-used window size and position
(when-let (dims (doom-store-get 'last-frame-size))
  (cl-destructuring-bind ((left . top) width height fullscreen) dims
    (setq initial-frame-alist
          (append initial-frame-alist
                  `((left . ,left)
                    (top . ,top)
                    (width . ,width)
                    (height . ,height)
                    (fullscreen . ,fullscreen))))))

(defun save-frame-dimensions ()
  (doom-store-put 'last-frame-size
                  (list (frame-position)
                        (frame-width)
                        (frame-height)
                        (frame-parameter nil 'fullscreen))))

;; When we kill emacs, save the current window size and position
(add-hook 'kill-emacs-hook #'save-frame-dimensions)

(setq window-combination-resize t)

;; Add a small amount of extra space in between each line
(setq line-spacing 2)

(setq catppuccin-flavor 'frappe) ;; or 'latte, 'macchiato, or 'mocha
(setq doom-theme 'catppuccin)

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(add-hook! '+indent-guides-inhibit-functions
  (defun justyn/indent-guides-in-org-mode-p ()
    (derived-mode-p 'org-mode)))

;; The double-buffering flicker fix is macOS-specific (Big Sur+); on Linux/GTK it can make
;; flicker/tearing worse, so only apply it on macOS.
(when (eq system-type 'darwin)
  (add-to-list 'default-frame-alist '(inhibit-double-buffering . t)))
(setq display-line-numbers-type nil)

;; TODO: This didn't work for me
;; (setq frame-title-format
;;       '(""
;;         (:eval
;;          (if (s-contains-p org-roam-directory (or buffer-file-name ""))
;;              (replace-regexp-in-string
;;               ".*/[0-9]*-?" "☰ "
;;               (subst-char-in-string ?_ ?  buffer-file-name))
;;            "%b"))
;;         (:eval
;;          (let ((project-name (projectile-project-name)))
;;            (unless (string= "-" project-name)
;;              (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))

(setq delete-by-moving-to-trash t)

(global-subword-mode 1)

(setq indent-tabs-mode nil
      tab-width 2)

(setq truncate-string-ellipsis "…")

(setq markdown-enable-wiki-links t
      markdown-enable-math t
      markdown-fontify-code-blocks-natively t
      markdown-wiki-link-search-subdirectories t)

(use-package! ox-gfm
  :after org)

(after! corfu
  (setq corfu-auto t
        corfu-auto-delay 0.5
        corfu-auto-prefix 2))

(after! magit
  ;; Set the directory where magit looks for repos in
  (setq magit-repository-directories '(("~/dev/" . 4))
        ;; Don't automatically save buffers when running magit
        magit-save-repository-buffers nil
        ;; Don't highlight tne entire hunk
        magit-diff-highlight-hunk-body nil))

(setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))

(use-package! treemacs-magit
  :defer t
  :after (treemacs magit))

(after! projectile
  (setq projectile-project-search-path '(("~/dev" . 3))))

(setq projectile-indexing-mode 'hybrid)

;; Source ssh-agent/gpg env vars from the `keychain' CLI tool, if the package loaded.
(when (fboundp 'keychain-refresh-environment)
  (keychain-refresh-environment))

;; Use /sshx because /ssh doesn't seem to work on bsd, and some of my
;; remote shells don't use sh/bash.  ssh/sshx should also be faster than scp
(setq tramp-default-method "sshx")

;; Use my default ctags configuration which excludes a lot of things we don't want
(setq projectile-tags-command (concat "ctags --options=" (expand-file-name "~/.ctags") " -Re -f \"%s\" %s \"%s\""))

(use-package! evil-snipe
  :defer t
  :config
  ;; Alias [ and ] to all types of brackets
  ;; With this, I can use evil-snipe by pressing f and then [ and it will search for any of these types of brackets
  (push '(?\[ "[[{(]") evil-snipe-aliases)
  (push '(?\] "[]})]") evil-snipe-aliases)
  (setq evil-snipe-scope 'visible)
  (setq evil-snipe-repeat-scope 'buffer)
  (setq evil-snipe-spillover-scope 'whole-buffer))

(setq make-backup-files t)

(save-place-mode 1)

(defhydra hydra-paste (:color red
                       :hint nil)
  "\n[%s(length kill-ring-yank-pointer)/%s(length kill-ring)] \
 [_C-j_/_C-k_] cycles through yanked text, [_p_/_P_] pastes the same text \
 above or below. Anything else exits."
  ("C-j" evil-paste-pop)
  ("C-k" evil-paste-pop-next)
  ("p" evil-paste-after)
  ("P" evil-paste-before))

(map! :nv "p" #'hydra-paste/evil-paste-after
      :nv "P" #'hydra-paste/evil-paste-before)

(setq avy-all-windows t)
