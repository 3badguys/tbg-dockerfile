(setq dir-name "_cc_build")
(or (file-exists-p dir-name)
    (make-directory dir-name "PARENTS"))

(setq script-url "https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh")
(let* ((script-name (file-name-base script-url))
       (script-path (format "./%s/%s.sh" dir-name script-name)))
  (or (file-exists-p script-path)
      (url-copy-file script-url script-path)))
