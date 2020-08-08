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



(setq org-agenda-files (quote ("~/org/")))
(setq org-refile-targets '((org-agenda-files . (:maxlevel . 3))))

;; Keywords to use by default in .org files

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "IN-PROGRESS(i!)" "|" "DONE(d!)")
        (sequence "WAITING(w@/!)" "BLOCKED(b@/!)" "|" "CANCELLED(c@/!)")
        (sequence "[ ](T)" "[-](P)" "[?](M)" "|" "[X](D)")))


;; Default Column View
(setq org-columns-default-format "%5TODO %30ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM(Clocked) %3PRIORITY(PRI) %TAGS")

;; Enable speed commands for single-key commands at the beginning of headers.  ? for help  TODO: I don't really know what these do
(setq org-use-speed-commands t)
;; Prettier code blocks
(setq org-src-fontify-natively t)
;; Hide code blocks by default in org-mode
'(org-hide-block-startup t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-noter-notes-search-path '("~/org/noter/"))

;; TODO: I'm not sure how to go to a specific window, so this really just goes left and right for now
(map! :leader
      (:desc "Window left" "1" #'evil-window-left
       :desc "Window right" "2" #'evil-window-right))
(map! :leader
      (:prefix ("w" . "window")
               (:desc "Window left" "1" #'evil-window-left
                :desc "Window right" "2" #'evil-window-right
                :desc "evil-window-vsplit" "|" #'evil-window-vsplit)))

;; Select-all
(map! "M-a" #'mark-whole-buffer)
;; Save
(map! "M-s" #'save-buffer)
;; Paste menu
(map! "M-v" #'counsel-yank-pop)

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

(setq doom-theme 'doom-one)
(load-theme doom-theme t)

(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Set the directory where magit looks for repos in
(setq magit-repository-directories '("~/dev/"))

(setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))

(use-package! treemacs-magit
  :defer t
  :after (treemacs magit))

;; (setq projectile-project-search-path '("~/dev/" "~/dev/clients/"))
;; Found on https://github.com/bbatsov/projectile/issues/1500
;; TODO: This still isn't recursive more than one level
(setq projectile-project-search-path (cddr (directory-files "~/dev" t)))

;; Use /sshx because /ssh doesn't seem to work on bsd, and some of my
;; remote shells don't use sh/bash.  ssh/sshx should also be faster than scp
(setq tramp-default-method "sshx")

;; Use my default ctags configuration which excludes a lot of things we don't want
(setq projectile-tags-command "ctags --options=~/.ctags -Re -f \"%s\" %s \"%s\"")

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

;; Save backups in one place
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; TODO: I'm not sure if I need this anymore?  It was originally because of Nextcloud having issues with my .org files
;; Disable lock files
;; (setq create-lockfiles nil)

;; Try to prevent emacs from using 100% cpu due to autosave
;; See https://github.com/syl20bnr/spacemacs/issues/9409
(setq history-length 350)
(put 'minibuffer-history 'history-length 50)
(put 'evil-ex-history 'history-length 50)
(put 'kill-ring 'history-length 25)

(use-package! recentf
  :defer t
  :ensure nil
  :hook (after-init . recentf-mode)
  :custom
  (recentf-auto-cleanup "05:00am")
  (recentf-max-saved-items 200)
  (recentf-exclude '((expand-file-name package-user-dir)
                     ".cache"
                     ".cask"
                     ".elfeed"
                     "bookmarks"
                     "cache"
                     "ido.*"
                     "persp-confs"
                     "recentf"
                     "undo-tree-hist"
                     "url"
                     "COMMIT_EDITMSG\\'")))

;; When buffer is closed, saves the cursor location
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

(setq which-key-idle-delay 0.25)

(setq avy-all-windows t)
