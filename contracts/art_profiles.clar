;; Art Profiles Smart Contract
;; This contract is part of the Art Portfolio Hub project and enables artists to register, update, and retrieve their profiles.
;; Profiles include details like name, art style, medium used, exhibitions, and portfolio links.

;; Map to store artist profiles
(define-map profiles
    principal
    {
        name: (string-ascii 100),              ;; Artist's name
        art_style: (string-ascii 100),        ;; Artist's preferred art style
        medium_used: (string-ascii 100),      ;; Medium used by the artist
        exhibitions: (list 10 (string-ascii 100)), ;; List of exhibitions the artist has participated in
        portfolio_links: (list 10 (string-ascii 200)) ;; Links to the artist's portfolio
    }
)

;; Error codes for handling invalid operations
(define-constant ERR-NOT-FOUND (err u404))          ;; Error when a profile is not found
(define-constant ERR-ALREADY-EXISTS (err u409))     ;; Error when a profile already exists
(define-constant ERR-INVALID-ARTSTYLE (err u400))   ;; Error for invalid art style
(define-constant ERR-INVALID-MEDIUM (err u401))     ;; Error for invalid medium
(define-constant ERR-INVALID-EXHIBITIONS (err u402)) ;; Error for invalid exhibitions
(define-constant ERR-INVALID-PORTFOLIO (err u403))  ;; Error for invalid portfolio links

;; Public function: Register a new artist profile
;; This function allows an artist to create their profile with details such as art style, medium used, exhibitions, and portfolio links.
(define-public (register-profile 
    (art_style (string-ascii 100))
    (medium_used (string-ascii 100))
    (exhibitions (list 10 (string-ascii 100)))
    (portfolio_links (list 10 (string-ascii 200))))
    (let
        (
            (caller tx-sender)
            (existing-profile (map-get? profiles caller))
        )
        ;; Ensure the profile does not already exist
        (if (is-none existing-profile)
            (begin
                ;; Validate input data
                (if (or (is-eq art_style "")
                        (is-eq medium_used "")
                        (is-eq (len exhibitions) u0)
                        (is-eq (len portfolio_links) u0))
                    (err ERR-INVALID-ARTSTYLE) ;; Handle invalid input
                    (begin
                        ;; Store the new profile
                        (map-set profiles caller
                            {
                                name: "",
                                art_style: art_style,
                                medium_used: medium_used,
                                exhibitions: exhibitions,
                                portfolio_links: portfolio_links
                            }
                        )
                        (ok "Profile registered successfully.")
                    )
                )
            )
            (err ERR-ALREADY-EXISTS)
        )
    )
)

;; Public function: Update an existing artist profile
;; This function allows an artist to update their profile details.
(define-public (update-profile
    (art_style (string-ascii 100))
    (medium_used (string-ascii 100))
    (exhibitions (list 10 (string-ascii 100)))
    (portfolio_links (list 10 (string-ascii 200))))
    (let
        (
            (caller tx-sender)
            (existing-profile (map-get? profiles caller))
        )
        ;; Ensure the profile exists before updating
        (match existing-profile
            profile
            (begin
                ;; Validate input data
                (if (or (is-eq art_style "")
                        (is-eq medium_used "")
                        (is-eq (len exhibitions) u0)
                        (is-eq (len portfolio_links) u0))
                    (err ERR-INVALID-ARTSTYLE) ;; Handle invalid input
                    (begin
                        ;; Update the profile
                        (map-set profiles caller
                            {
                                name: (get name profile),
                                art_style: art_style,
                                medium_used: medium_used,
                                exhibitions: exhibitions,
                                portfolio_links: portfolio_links
                            }
                        )
                        (ok "Profile updated successfully.")
                    )
                )
            )
            (err ERR-NOT-FOUND)
        )
    )
)

;; Read-only function: Retrieve an artist's full profile
;; Allows anyone to retrieve the complete profile of a specified artist.
(define-read-only (get-profile (user principal))
    (match (map-get? profiles user)
        profile (ok profile)
        ERR-NOT-FOUND
    )
)

;; Read-only function: Retrieve the art style of a specific artist
;; Provides the art style of the given artist.
(define-read-only (get-art-style (user principal))
    (match (map-get? profiles user)
        profile (ok (get art_style profile))
        ERR-NOT-FOUND
    )
)

;; Read-only function: Retrieve the exhibitions of a specific artist
;; Returns the list of exhibitions an artist has participated in.
(define-read-only (get-exhibitions (user principal))
    (match (map-get? profiles user)
        profile (ok (get exhibitions profile))
        ERR-NOT-FOUND
    )
)

;; Read-only function: Retrieve the portfolio links of a specific artist
;; Returns the portfolio links of the given artist.
(define-read-only (get-portfolio-links (user principal))
    (match (map-get? profiles user)
        profile (ok (get portfolio_links profile))
        ERR-NOT-FOUND
    )
)
