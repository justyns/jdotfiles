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

(defun justyn/doom-sync-and-build ()
  "Runs doom sync and then doom build"
  (interactive)
  (shell-command "doom sync && doom build"))

(defun justyn/doom-sync ()
  "Runs doom sync"
  (interactive)
  (shell-command "doom sync"))

(map! :leader
      (:prefix ("j" . "justyn")
               (:prefix ("d" . "doom")
                        :desc "Doom sync" "s" #'justyn/doom-sync
                        :desc "Doom sync/build" "S" #'justyn/doom-sync-and-build)))

(use-package! beancount
  :mode ("\\.beancount\\'" . beancount-mode)
  :defer t
  :init (add-hook 'beancount-mode-hook #'outline-minor-mode)
  :init)

(if (file-exists-p "~/.doom.local.el")
    (load-file "~/.doom.local.el"))

(setq-default custom-file (expand-file-name ".custom.el" doom-private-dir))
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
  '(org-hide-block-startup t)

  ;; Open .org files as folded by default
  (setq org-startup-folded 'overview)
  )

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads, so don't use after!
(setq org-directory "~/org/")
(setq org-noter-notes-search-path '("~/org/noter/"))

(use-package! helm-org-rifle
  :defer t)
(map! :leader
      (:prefix ("j" . "justyn")
               (:desc "helm-org-rifle" "r" #'helm-org-rifle)))

(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  (goto-char (point-min)))

;;(org-journal-find-location)

;; (use-package! org-journal
;;   :defer t
;;   :config
;; (after! org-journal
;; TODO: I might want to use monthly instead?  I'm not sure if weekly will be too many files or not.
;; TODO: Store each journal entry into something like YYYY/MM/Week1.org
(setq org-journal-file-type "weekly")
(setq org-journal-dir "~/org/journal/")
(setq org-journal-file-format "%Y-%m-%d.org")
;; TODO: This breaks my agenda when non-nil, but I include ~/org anyways
(setq org-journal-enable-agenda-integration nil)
(setq org-journal-date-format "%A - %B %d, %Y")
(setq org-journal-file-header "#+TITLE: Weekly Worklog\n#+STARTUP: folded\n")

(setq org-crypt-key "AA5A79D7AD584854")

(use-package! ox-jira
  :after org)

;; Deft settings
;; I created symlinks in ~/.deft pointing to my org notes/joplin/etc
(setq deft-directory "~/.deft"
      deft-extensions '("org" "md" "txt")
      deft-recursive t
      deft-default-extension "md"
      deft-text-mode 'org-mode

      ;; TODO: Figure out how to make this work with stuff like Joplin's markdown format
      ;; See https://jingsi.space/post/2017/04/05/organizing-a-complex-directory-for-emacs-org-mode-and-deft/
      deft-use-filename-as-title nil
      deft-use-filter-string-for-filename t
      deft-file-naming-rules '((nospace . "-")
                               (case-fn . downcase))
      ;; Limit the number of files Deft shows by default to speed it up
      deft-file-limit 100)

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

(setq window-combination-resize t)

(setq doom-theme 'doom-vibrant)
(load-theme doom-theme t)

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(setq highlight-indent-guides-responsive 'stack)

(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
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

(setq truncate-string-ellipsis "…")

(setq markdown-enable-wiki-links t
      markdown-enable-math t
      markdown-fontify-code-blocks-natively t
      markdown-wiki-link-search-subdirectories t)

(use-package! ox-gfm
  :after org)

(after! lsp
  :config
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection '("/usr/local/bin/terraform-ls" "serve"))
                      :major-modes '(terraform-mode)
                      :server-id 'terraform-ls))

    (add-hook 'terraform-mode-hook #'lsp)
  )

(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2)
  (setq company-show-numbers t)
  (add-hook 'evil-normal-state-entry-hook #'company-abort)) ;; make aborting less annoying.

(after! magit
  :config
  ;; Set the directory where magit looks for repos in
  (setq magit-repository-directories '(("~/dev/" . 4))
        ;; Don't automatically save buffers when running magit
        magit-save-repository-buffers nil)
  )
(after! projectile
  :config
  (when (require 'magit nil t)
    (mapc #'projectile-add-known-project
          (mapcar #'file-name-as-directory (magit-list-repos)))
    ;; Optionally write to persistent `projectile-known-projects-file'
    (projectile-save-known-projects)))

(setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))

(use-package! treemacs-magit
  :defer t
  :after (treemacs magit))

;; (setq projectile-project-search-path '("~/dev/" "~/dev/clients/"))
;; Found on https://github.com/bbatsov/projectile/issues/1500
;; TODO: This still isn't recursive more than one level
(setq projectile-project-search-path (cddr (directory-files "~/dev" t)))

(setq projectile-indexing-mode 'hybrid)

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

(setq
 auto-save-default t
 make-backup-files t
 create-lockfiles nil
 )

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

;; (use-package! kubel)
;; (use-package! kubel-evil)

(yas-global-mode 1)

(use-package! powerthesaurus
  :defer t)
(map! :leader
      (:prefix ("a" . "applications")
               :desc "Use powerthesaurus to fetch better word" "p" #'powerthesaurus-lookup-word-dwim))

(use-package! string-inflection
  :defer t)
(map! :leader
      (:prefix ("a" . "applications")
               :desc "Cycle through string case using String-inflection" "c" #'string-inflection-all-cycle))

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

(after! org
  (use-package! org-mru-clock
    :config
    (setq org-mru-clock-how-many 50)
    )

  (setq org-clock-persist t)
  (org-clock-persistence-insinuate)

  (setq bh/keep-clock-running nil)
  (add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)

  ;; Delete clocks that are 0:00
  (setq org-clock-out-remove-zero-time-clocks t)
  ;; Include current task in clock report
  (setq org-clock-report-include-clocking-task t)
  ;; Store clock history for longer
  (setq org-clock-history-length 15)
  ;; Clock report default params
  (setq org-agenda-clockreport-parameter-plist
        (quote (:link t :maxlevel 3 :fileskip0 t :compact t :narrow 100)))
  )

(after! org
  (use-package! org-expiry
    :config
    (setq org-expiry-created-property-name "CREATED"
          org-expiry-inactive-timestamps t)
    (org-expiry-insinuate)
    )
  )

(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-include-deadlines t
        org-agenda-block-separator nil
        org-agenda-compact-blocks t
        org-agenda-start-day nil ;; i.e. today
        org-agenda-span 1
        org-agenda-start-on-weekday nil)
  (setq org-agenda-custom-commands
        '(("c" "Super view"
           ((agenda "" ((org-agenda-overriding-header "")
                        (org-super-agenda-groups
                         '((:name "Today"
                                  :time-grid t
                                  :date today
                                  :todo "TODAY"
                                  :scheduled today
                                  :order 1)))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:log t)
                            (:name "In-Progress"
                                   :todo "IN-PROGRESS"
                                   :order 2)
                            (:name "Waiting/Blocked"
                                   :todo ("WAITING" "BLOCKED")
                                   :order 3)
                            (:name "Next to do"
                                   :todo "NEXT"
                                   :order 4)
                            (:name "Due Today"
                                   :deadline today
                                   :order 5)
                            (:name "Overdue"
                                   :deadline past
                                   :order 6)
                            (:name "Scheduled Soon"
                                   :scheduled future
                                   :order 7)
                            (:name "Important"
                                   :priority "A"
                                   :order 8)
                            (:name "Meetings"
                                   :and (:todo "meeting" :scheduled future)
                                   :order 10)
                            (:discard (:not (:todo "TODO")))))))))))
:config
(org-super-agenda-mode))

;; Helper to determine what my current worklog .org file is
;; TODO: Also create the file with a template if needed
;; TODO: Test if this works when the month changes, and isn't evaluated during startup only
(defun justyn/current-worklog-file ()
  (expand-file-name (format-time-string "worklog-%Y-%m.org") org-directory)
  )
;; (justyn/current-worklog-file)

(after! org
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
           entry (file+olp+datetree "~/org/journal.org.gpg")
           "* %? \nCREATED: %U\n%i\n%a"
           :empty-lines 1)
          ;; TODO: Use year in filename automatically
          ("w" "New WorkLog entry"
           entry (file+olp+datetree justyn/current-worklog-file)
           "* %? :work:\nCREATED: %T\n%i\n%a\n"
           :clock-in t
           :clock-resume t
           :empty-lines 1)
          ("W" "New Work Ticket"
           entry (file+olp+datetree justyn/current-worklog-file)
           "* IN-PROGRESS %^{TicketID}: %^{Title} :work:ticket:
:PROPERTIES:
:ID: %\\1
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
           entry (file+olp+datetree justyn/current-worklog-file)
           "* Meeting for %^{Title} :work:meeting:\nCREATED: %T\nAgenda/Purpose: \nWho: \n\n - %?\n"
           :empty-lines 1
           :clock-in t
           :clock-resume t)
          ("M" "Adhoc Meeting(Chat/InPerson/Email/Etc)"
           entry (file+olp+datetree justyn/current-worklog-file)
           "* Adhoc meeting w/ %^{Who} about %^{What} :work:meeting:\nCREATED: %T\nWho: %\\1 \nNotes: %?\n"
           :empty-lines 1
           :clock-in t
           :clock-resume t)
          ("f" "Todo - Follow-up later today on e-mail/slack/etc"
           entry (file+olp+datetree justyn/current-worklog-file)
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
  )

;; TODO: Maybe map this to SPC m c like where doom puts the clock stuff currently?
(map! :leader
      (:prefix ("j" . "justyn")
               (:desc "org-mru-clock-in" "c" #'org-mru-clock-in
                :desc "org-mru-clock-select-recent-task" "C" #'org-mru-clock-select-recent-task
                :desc "bh/punch-in" "p" #'bh/punch-in
                :desc "bh/punch-out" "P" #'bh/punch-out
                :desc "org-save-all-org-buffers" "s" #'org-save-all-org-buffers)))

;; Add a small amount of extra space in between each line
(setq line-spacing 2)

(setq indent-tabs-mode nil
      tab-width 2)

;; Currently disabled because this is now built into the core of doom emacs, and it does it better (lazily)
;; (use-package! autorevert
;;   :defer t
;;   :ensure nil
;;   :config
;;   (global-auto-revert-mode +1)
;;   (setq auto-revert-interval 2
;;         auto-revert-check-vc-info t
;;         auto-revert-verbose nil))

;; Source ssh-agent from keychain
(keychain-refresh-environment)

(setq avy-all-windows t)

(after! pdf-view
  ;; open pdfs scaled to fit page
  (setq-default pdf-view-display-size 'fit-width)
  ;; automatically annotate highlights
  (setq pdf-annot-activate-created-annotations t
        org-noter-insert-note-no-questions t
        pdf-view-resize-factor 1.1)
  ;; faster motion
  (map!
   :map pdf-view-mode-map
   :n "g g"          #'pdf-view-first-page
   :n "G"            #'pdf-view-last-page
   :localleader
   (:desc "Insert" "i" 'org-noter-insert-note)
   ))
