(define (says input-image output-image words dark-file light-file screen-width screen-height x1 y1 x2 y2 x3 y3 x4 y4)
    (let* ((image (car (gimp-file-load RUN-NONINTERACTIVE input-image input-image)))                                  ;; load the background image
           (background (car (gimp-image-get-active-layer image)))
           (image-width (car (gimp-image-width image)))                                                               ;; get the image width & height
           (image-height (car (gimp-image-height image)))
           (projector (car (gimp-layer-new image screen-width screen-height RGBA-IMAGE "projector" 100 NORMAL-MODE))) ;; make a layer called 'projector' for the text
           (noret (car (gimp-image-insert-layer image projector 0 -1)))                                               ;; add 'projector' layer to drawing
           (text-layer (car (gimp-text-fontname image -1 0 0 words 15 TRUE 80 PIXELS "sans-serif")))                  ;; draw text, currently floating layer
           (noret (car (gimp-text-layer-set-justification text-layer TEXT-JUSTIFY-CENTER)))                           ;; set text alignment
           (text-width (car (gimp-drawable-width text-layer)))                                                        ;; put text in middle of projector layer
           (text-height (car (gimp-drawable-height text-layer)))
           (noret (car (gimp-layer-translate text-layer (- (/ screen-width 2) (/ text-width 2))
                                                        (- (/ screen-height 2) (/ text-height 2)))))

        ;    (noret (car (gimp-file-save RUN-NONINTERACTIVE image background "generated/pre-projector.xcf" "generated/pre-projector.xcf")))

           (projector (car (gimp-image-merge-down image text-layer EXPAND-AS-NECESSARY)))                             ;; merge text layer onto projector
           (projector (car (gimp-item-transform-perspective projector x1 y1 x2 y2 x3 y3 x4 y4)))                      ;; perspective transform projector layer

           ; merge colours with specified overlay files
           ; light is currently ignored because it's not quite right
        ;    (light-overlay (car (gimp-file-load-layer RUN-NONINTERACTIVE image light-file)))
        ;    (noret (car (gimp-layer-set-mode light-overlay BURN-MODE)))
        ;    (noret (car (gimp-image-insert-layer image light-overlay 0 -1)))

           (dark-overlay (car (gimp-file-load-layer RUN-NONINTERACTIVE image dark-file)))
           (noret (car (gimp-layer-set-mode dark-overlay SCREEN-MODE)))
           (noret (car (gimp-image-insert-layer image dark-overlay 0 -1)))

        ;    (noret (car (gimp-file-save RUN-NONINTERACTIVE image background "generated/most-recent.xcf" "generated/most-recent.xcf")))

        ;    (background (car (gimp-image-merge-down image projector EXPAND-AS-NECESSARY)))
        ;    (background (car (gimp-image-merge-down image light-overlay EXPAND-AS-NECESSARY)))
           (projector (car (gimp-image-merge-down image dark-overlay EXPAND-AS-NECESSARY)))

           ; add watermark

           (watermark (car (gimp-file-load-layer RUN-NONINTERACTIVE image "overlays/watermark.png")))
           (noret (car (gimp-image-insert-layer image watermark 0 -1)))
           (watermark-width (car (gimp-drawable-width watermark)))
           (watermark-height (car (gimp-drawable-height watermark)))
           (noret (car (gimp-layer-translate watermark (- image-width watermark-width)
                                                       (- image-height watermark-height ))))

           (background (car (gimp-image-merge-visible-layers image CLIP-TO-BOTTOM-LAYER)))                           ;; merge layers before exporting to jpg
          )
        (gimp-file-save RUN-NONINTERACTIVE image background output-image output-image))
)
