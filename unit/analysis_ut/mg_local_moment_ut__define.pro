function mg_local_moment_ut::test1
  compile_opt strictarr

  assert, mg_idlversion(require='8.1'), /skip, $
          'test requires IDL 8.1, %s present', !version.release

  x = findgen(10)

  result = mg_local_moment(x, 3)
  standard = [findgen(9), 0.]

  assert, array_equal(result, standard), 'incorrect result'

  return, 1
end


pro mg_local_moment_ut__define
  compile_opt strictarr

  define = { mg_local_moment_ut, inherits MGutLibTestCase }
end
