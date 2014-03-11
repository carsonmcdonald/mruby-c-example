#include "mruby.h"
#include "mruby/irep.h"
#include "mruby/string.h"

#include "simple_class_mrb.h"

static mrb_value foo_init(mrb_state* mrb, mrb_value self)
{
  mrb_value message;
  mrb_get_args(mrb, "S", &message);

  if (!mrb_nil_p(message))
  {
    fprintf(stderr, "foo initialized with: %s\n", mrb_str_ptr(message)->ptr);
  }

  return self;
}

static mrb_value foo_bar(mrb_state* mrb, mrb_value obj)
{
  mrb_value message;
  mrb_get_args(mrb, "S", &message);

  if (!mrb_nil_p(message))
  {
    fprintf(stderr, "bar: %s\n", mrb_str_ptr(message)->ptr);
  }

  return mrb_nil_value();
}

int main(void)
{
  mrb_state *mrb = mrb_open();

  struct RClass *foo_class = mrb_define_class(mrb, "Foo", mrb->object_class);

  mrb_define_method(mrb, foo_class, "initialize", foo_init, ARGS_REQ(1));
  mrb_define_method(mrb, foo_class, "bar", foo_bar, ARGS_REQ(1));

  mrb_load_irep(mrb, simple_class_mrb);

  mrb_close(mrb);

  return 0;
}
