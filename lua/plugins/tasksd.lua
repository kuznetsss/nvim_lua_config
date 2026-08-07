return {
  {
    'kuznetsss/tasksd-client.nvim',
    cmd = 'Tasksd',
    ---@module "tasksd"
    opts = {
      -- see Configuration below; {} is a fine starting point
    },
    keys = {
      {
        '<F5>',
        '<cmd>Tasksd start_task<CR>',
      },
      {
        '<F6>',
        '<cmd>Tasksd repeat<CR>',
      },
      {
        '<F7>',
        '<cmd>Tasksd send_signal task_id=last signal=9<CR>',
      },
      {
        '<F8>',
        '<cmd>Tasksd output<CR>',
      },
    },
  },
}
