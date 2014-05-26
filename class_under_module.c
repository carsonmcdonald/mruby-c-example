#include "mruby.h"
#include "mruby/irep.h"
#include "mruby/string.h"

#include "class_under_module_mrb.h"

static mrb_value foo_bar_init(mrb_state* mrb, mrb_value self)
{
  char *message = NULL;
  mrb_get_args(mrb, "z", &message);

  fprintf(stderr, "Foo::Bar initialized with: %s\n", message);

  return self;
}

static mrb_value foo_bar_baz(mrb_state* mrb, mrb_value obj)
{
  char *message = NULL;
  mrb_get_args(mrb, "z", &message);

  fprintf(stderr, "baz: %s\n", message);

  return mrb_nil_value();
}

int main(void)
{
  mrb_state *mrb = mrb_open();

  struct RClass *foo_module = mrb_define_module(mrb, "Foo");

  struct RClass *foo_class = mrb_define_class_under(mrb, foo_module, "Bar", mrb->object_class);

  mrb_define_method(mrb, foo_class, "initialize", foo_bar_init, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, foo_class, "baz", foo_bar_baz, MRB_ARGS_REQ(1));

  // To get the class use: mrb_class_get_under(mrb, foo_module, "Bar");

  mrb_load_irep(mrb, class_under_module_mrb);

  mrb_close(mrb);

  return 0;
}
