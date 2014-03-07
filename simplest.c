#include "mruby.h"
#include "mruby/irep.h"

#include "simplest_mrb.h"

int main(void)
{
  mrb_state *mrb = mrb_open();

  mrb_load_irep(mrb, simplest_mrb);

  mrb_close(mrb);

  return 0;
}
