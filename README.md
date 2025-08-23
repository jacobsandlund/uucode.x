# uucode.x

ARCHIVED. For now, it's too difficult to manage wiring up these extensions with
`uucode` in zig build. These have been included in `uucode` itself (still as extensions).

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

// Some extensions define types that need to be resolved from `config_x`, so
// this should be exactly `pub const config_x`.
pub const config_x = @import("config.x.zig");
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

Note: while many extensions will just be setting new properties, and those can directly be used via `uucode.get`, for some library code, until [#1](https://github.com/jacobsandlund/uucode.x/issues/1) is solved, the source code will need to be copied into your code. See `src/root.zig` and the files under `src/` to see which ones need to be copied and which can be used via the `uucode.x` dependency.
