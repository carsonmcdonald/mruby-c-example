#include "mruby.h"
#include "mruby/irep.h"
#include "mruby/string.h"

#include "simple_module_mrb.h"

static mrb_value foo_bar(mrb_state* mrb, mrb_value obj)
{
  char *message = NULL;
  mrb_get_args(mrb, "z", &message);

  fprintf(stderr, "bar: %s\n", message);

  return mrb_nil_value();
}

int main(void)
{
  mrb_state *mrb = mrb_open();

  struct RClass *foo_module = mrb_define_module(mrb, "Foo");

  mrb_define_class_method(mrb, foo_module, "bar", foo_bar, MRB_ARGS_REQ(1));

  mrb_load_irep(mrb, simple_module_mrb);

  mrb_close(mrb);

  return 0;
}
