(define (dan words newname)
    (says "dan.jpg" newname words 147 95 74
                                  640 480
                                  44 21 328 188 24 402 328 436)
)

(define (says input-image output-image words black-red black-green black-blue screen-width screen-height x1 y1 x2 y2 x3 y3 x4 y4)
    (let* ((image (car (gimp-file-load RUN-NONINTERACTIVE input-image input-image)))                                 ;; load the background image
           (background (car (gimp-image-get-active-layer image)))
           (image-width (car (gimp-image-width image)))                                                              ;; get the image width & height
           (image-height (car (gimp-image-height image)))
           (projector (car (gimp-layer-new image screen-width screen-height RGBA-IMAGE "projector" 100 NORMAL-MODE)))  ;; make a layer called 'projector' for the text
           (noret (car (gimp-image-insert-layer image projector 0 -1)))                                              ;; add 'projector' layer to drawing
           (text-layer (car (gimp-text-fontname image -1 0 0 words 0 TRUE 80 PIXELS "sans-serif")))                  ;; draw text, currently floating layer
           (noret (car (gimp-text-layer-set-color text-layer (list black-red black-green black-blue))))              ;; set text colour
           (noret (car (gimp-text-layer-set-justification text-layer TEXT-JUSTIFY-CENTER)))                          ;; set text alignment
           (text-width (car (gimp-drawable-width text-layer)))                                                       ;; put text in middle of projector layer
           (text-height (car (gimp-drawable-height text-layer)))
           (noret (car (gimp-layer-translate text-layer (- (/ screen-width 2) (/ text-width 2))
                                                        (- (/ screen-height 2) (/ text-height 2)))))

           ; merge colours (for images)
        ;    (black-layer (car (gimp-layer-new image image-width image-height RGBA-IMAGE "black-layer" 100 SCREEN-MODE)))
        ;    (noret (car (gimp-image-insert-layer image black-layer 0 -1)))
        ;    (noret (car (gimp-context-set-background (list black-red black-green black-blue))))
        ;    (noret (car (gimp-drawable-fill black-layer BACKGROUND-FILL)))
        ;    (text-layer (car (gimp-image-merge-down image black-layer CLIP-TO-BOTTOM-LAYER)))

           (projector (car (gimp-image-merge-down image text-layer EXPAND-AS-NECESSARY)))                            ;; merge text layer onto projector
           (projector (car (gimp-item-transform-perspective projector x1 y1 x2 y2 x3 y3 x4 y4)))                     ;; perspective transform projector layer
           (background (car (gimp-image-merge-visible-layers image CLIP-TO-BOTTOM-LAYER)))                           ;; merge layers before exporting to jpg
          )
        (gimp-file-save RUN-NONINTERACTIVE image background output-image output-image))
)
