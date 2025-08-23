# uucode.x

Community extensions for [uucode](https://github.com/jacobsandlund/uucode).


## Super basic usage

``` zig
//////////////////////
// getting properties

cp = 0x26F5; // ⛵
uucode.get(.wcwidth, cp) // 2
```

### Configuration

``` zig
const config = @import("config.zig");
const config_x = @import("config.x.zig");
const d = config.default;
const wcwidth = config_x.wcwidth;

pub const tables = [_]config.Table{
    .{
        .extensions = &.{wcwidth},
        .fields = &.{
            wcwidth.field("wcwidth"),
            d.field("general_category"),
            d.field("block"),
            // ...
        },
    },
};
```

Note: while many extensions will just be setting new properties, and those can directly be used via `uucode.get`, for any library code, until [#1](https://github.com/jacobsandlund/uucode.x/issues/1) is solved, copy the source into your code.
