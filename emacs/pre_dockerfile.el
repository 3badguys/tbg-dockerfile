(setq dir-name "_cc_build")
(or (file-exists-p dir-name)
    (make-directory dir-name "PARENTS"))

(setq repo-links
      '(
        ("git@github.com:3badguys/.emacs.d.git" . ("--origin=origin" "--recurse-submodules"))
        ("https://github.com/xahlee/xah-fly-keys.git" . ("--origin=origin"))
        ("git@github.com:3badguys/xah-elisp-mode.git" . ("--origin=origin"))
        ("git://git.sv.gnu.org/emacs.git" . ("--origin=origin"))
        ))

(setq magit-clone-set-remote.pushDefault t)
(dolist (repo-info repo-links)
  (let* ((repo-link (car repo-info))
         (repo-args (cdr repo-info))
         (repo-name (file-name-base repo-link))
         (repo-dir (format "./%s/%s" dir-name repo-name)))
    (or (file-exists-p repo-dir)
        (magit-clone-regular repo-link repo-dir repo-args))))
