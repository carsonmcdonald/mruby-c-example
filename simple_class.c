#include "mruby.h"
#include "mruby/irep.h"
#include "mruby/string.h"

#include "simple_class_mrb.h"

static mrb_value foo_init(mrb_state* mrb, mrb_value self)
{
  char *message = NULL;
  mrb_get_args(mrb, "z", &message);

  fprintf(stderr, "foo initialized with: %s\n", message);

  return self;
}

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

  struct RClass *foo_class = mrb_define_class(mrb, "Foo", mrb->object_class);

  mrb_define_method(mrb, foo_class, "initialize", foo_init, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, foo_class, "bar", foo_bar, MRB_ARGS_REQ(1));

  mrb_load_irep(mrb, simple_class_mrb);

  mrb_close(mrb);

  return 0;
}
