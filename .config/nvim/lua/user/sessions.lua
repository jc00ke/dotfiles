local status_ok, auto_session = pcall(require, "auto-session")
if not status_ok then
  return
end

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

auto_session.setup {
  log_level = 'info',
  auto_session_suppress_dirs = {'~/', '~/Projects'}
}
