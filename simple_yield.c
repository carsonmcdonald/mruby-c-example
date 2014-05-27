#include "mruby.h"
#include "mruby/irep.h"
#include "mruby/string.h"

#include "simple_yield_mrb.h"

static mrb_value foo_init(mrb_state* mrb, mrb_value self)
{
  return self;
}

static mrb_value foo_bar(mrb_state* mrb, mrb_value obj)
{
  mrb_value block;
  mrb_get_args(mrb, "&", &block);

  fprintf(stderr, "Before block\n");

  mrb_yield_argv(mrb, block, 0, NULL);

  fprintf(stderr, "After block\n");

  return mrb_nil_value();
}

int main(void)
{
  mrb_state *mrb = mrb_open();

  struct RClass *foo_class = mrb_define_class(mrb, "Foo", mrb->object_class);

  mrb_define_method(mrb, foo_class, "initialize", foo_init, MRB_ARGS_NONE());
  mrb_define_method(mrb, foo_class, "bar", foo_bar, ARGS_BLOCK());

  mrb_load_irep(mrb, simple_yield_mrb);

  mrb_close(mrb);

  return 0;
}
