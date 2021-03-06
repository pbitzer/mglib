; docformat = 'rst'

;+
; This is a base class to inherit from to create an object widget.
;-


;+
; Set properties of the object widget.
;
; :Keywords:
;    title : in, optional, type=string
;       title of the base
;    offset : in, optional, type=lonarr(2)
;       offset in pixels of the upper-left corner of the base from the
;       upper-left corner of the widget
;-
pro mgwidobjectwidget::setProperty, title=title, offset=offset
  compile_opt strictarr

  if (n_elements(title) gt 0) then begin
    widget_control, self.tlb, tlb_set_title=title
  endif

  if (n_elements(offset) gt 0) then begin
    widget_control, self.tlb, $
                    tlb_set_xoffset=offset[0], $
                    tlb_set_yoffset=offset[1]
  endif
end


;+
; Get properties of the object widget.
;
; :Keywords:
;    offset : out, optional, type=lonarr(2)
;       offset in pixels of the upper-left corner of the base from the
;       upper-left corner of the widget
;    size : out, optional, type=lonarr(2)
;       size in pixels of the tlb
;-
pro mgwidobjectwidget::getProperty, offset=offset, size=size
  compile_opt strictarr

  widget_control, self.tlb, tlb_get_offset=offset, size=size
end


;+
; Event handler for all widgets in the program.
;
; :Abstract:
;
; :Params:
;    event : in, required, type=structure
;       event structure for any generated by the widget program
;-
pro mgwidobjectwidget::handle_events, event
  compile_opt strictarr

end


;+
; Called when the widget program is being destroyed.
;
; :Abstract:
;
; :Params:
;    tlb : in, required, type=long
;       widget ID for the top-level base
;-
pro mgwidobjectwidget::cleanup_widgets, tlb
  compile_opt strictarr

end


;+
; Create widget hierarchy. Make sure to store the top-level base widget
; identifier in `self.tlb` and put `self` in the tlb's `UVALUE`.
;
; :Abstract:
;-
pro mgwidobjectwidget::create_widgets
  compile_opt strictarr

end


;+
; Override in subclasses to do actions that must be done after realization.
;-
pro mgwidobjectwidget::realize_widgets
  compile_opt strictarr

  widget_control, self.tlb, /realize
end


;+
; Start XMANAGER.
;-
pro mgwidobjectwidget::start_xmanager
  compile_opt strictarr

  ; start up events
  xmanager, self.name, self.tlb, /no_block, $
            event_handler='mg_object_event_handler', $
            cleanup='mg_object_cleanup'
 end


;+
; Cleanup resources.
;-
pro mgwidobjectwidget::cleanup
  compile_opt strictarr

end


;+
; Create on object widget.
;
; :Returns:
;    1B for success, 0B otherwise
;-
function mgwidobjectwidget::init, name=name
  compile_opt strictarr

  self.name = n_elements(name) eq 0 ? obj_class(self) : name

  return, 1B
end


;+
; Define member variables.
;
; :Fields:
;    tlb
;       top-level base widget ID
;    name
;       name of the widget program
;-
pro mgwidobjectwidget__define
  compile_opt strictarr

  define = { MGwidObjectWidget, $
             tlb : 0L, $
             name : '' $
           }
end
