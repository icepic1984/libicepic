(define-module (libicepic)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix utils)
  #:use-module (guix packages)
  #:use-module (guix git)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module (guix hash)
  #:use-module (guix gexp)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages web))


;;https://notabug.org/cwebber/guile-gcrypt/src/master/guix.scm

(define-public libicepic
  (package
    (name "libicepic")
    (version "0.1.0")
    (source (local-file "/home/icepic/guix/packages/libicepic" #:recursive? #t))
    ;; (source
    ;;  (origin (method git-fetch)
    ;;           (uri (git-reference (url
    ;;                                "file:///home/icepic/guix/packages/libicepic")
    ;;                               (commit
    ;;                                "e66f822800af3c776b7a20681d704dd442d8ccbd")))
    ;;           (file-name (git-file-name name version))
    ;;           (sha256 (base32
    ;;           "17pjvprmdrx4h6bb1hhc98w9qi6ki7yl57f090n9kbhswxqfs7s3"))))
    (build-system cmake-build-system)
    (arguments
     `(#:tests? #f ))
    (outputs '("out" "debug"))
    (license license:gpl3+)
    (description "test")
    (home-page "https://icepic.org")
    (synopsis "Library to test guix")))


