;; Simple Proof of Completion Contract
;; Stores and verifies proof commitments without revealing content

;; Error constants
(define-constant err-not-submitter (err u100))
(define-constant err-proof-not-found (err u101))

;; Map: user principal -> proof commitment (hash)
(define-map proof-commits principal (buff 32))

;; Function 1: Submit proof commitment (only sender can submit their own)
(define-public (submit-proof (proof (buff 32)))
  (begin
    (map-set proof-commits tx-sender proof)
    (ok true)
  )
)

;; Function 2: Verify stored proof commitment for a given user
(define-read-only (verify-proof (user principal) (proof (buff 32)))
  (let ((stored-proof (map-get? proof-commits user)))
    (match stored-proof
      proof-commit
        (ok (is-eq proof proof-commit))
      none
        err-proof-not-found
    )
  )
)
