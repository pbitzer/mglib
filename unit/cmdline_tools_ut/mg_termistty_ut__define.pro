; docformat = 'rst'


function mg_termistty_ut::test_boolean
  compile_opt strictarr

  assert, self->have_dlm('mg_analysis'), 'MG_CMDLINE_TOOLS DLM not found', /skip

  isTty = mg_termistty()

  assert, isTty eq 0B || isTty eq 1B, 'assert invalid boolean value'

  return, 1
end


;+
; Define instance variables.
;-
pro mg_termistty_ut__define
  compile_opt strictarr

  define = { mg_termistty_ut, inherits MGutLibTestCase }
end
