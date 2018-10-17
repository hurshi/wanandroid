# coding: u8

import re
from pathlib import Path


ROOT = Path(__file__).resolve().parent
MAIN = ROOT


# 将 iconfont 的 css 自动转换为 dart 代码

def translate():
    print('Begin translate...')

    code = """
import 'package:flutter/widgets.dart';


// 代码由程序自动生成。
// 请不要对此文件做任何修改。详细说明见本文件末尾


class IconF {

    IconF._();

    static const font_name = 'iconfont';

{icon_codes}
}
""".strip()

    strings = []

    tmp = []
    p = re.compile(r'.icon-(.*?):.*?"\\(.*?)";')
    for line in open(MAIN / 'iconfont.css'):
        line = line.strip()
        if line:
            res = p.findall(line)
            if res:
                name, value = res[0]
                name = name.replace('-', '_')
                tmp.append((name.lower(), value))

    tmp.sort()
    for name, value in tmp:
        string = f'    static const IconData {name} = const IconData(0x{value}, fontFamily: font_name);'
        strings.append(string)

    strings = '\n'.join(strings)
    code = code.replace('{icon_codes}', strings)

    open(MAIN / 'IconF.dart', 'w').write(code)

    print('Finish translate...')


if __name__ == "__main__":
    translate()
