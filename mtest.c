#include "mruby.h"
#include "mruby/irep.h"

#include "testrb.h"

int main(void)
{
  mrb_state *mrb = mrb_open();

  mrb_load_irep(mrb, test_mrp);

  mrb_close(mrb);

  return 0;
}
