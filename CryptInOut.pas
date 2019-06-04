Program CryptInOut;
uses crt;
const
   max_menu = 40;
   ABC0 = ' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZабвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ!"№;%:?*()_+@#$^&-=`~\|/{[}]<>';
   ABC1 = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
   ABC2 = '0123456789абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';
   ABC3 = 'abcdefghijklmnopqrstuvwxyz';
   ABC4 = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя';
   ABC5 = '0123456789';
type
   Tfunc = function(x: int64): int64;
   Tcod = record
      cod1: integer;
      cod2: integer;
   end;
   Tcod_menu = array[1..max_menu] of integer;
   Settle = record
      x: integer;
      y: integer;
      color: integer;
   end;
   Tgame1 = array[-3..4] of Settle;
var
   s0, s, message: string;
   b: boolean;
   cod: Tcod;
   cod_menu_pos: Tcod_menu;
   cod_menu_num: Tcod_menu;
   f: text;
   path_in, path_out: string;
   autosave: boolean;
   ABC: string := ABC0;
Function CanResetFile(var F: textfile): boolean;
begin
   try
      Reset(F);
      Result := true;
   except
      Result := false;
   end;
end;

Function CanRewriteFile(var F: textfile): boolean;
begin
   try
      Rewrite(F);
      Result := true;
   except
      Result := false;
   end;
end;

Function CanAppendFile(var F: textfile): boolean;
begin
   try
      Append(F);
      Result := true;
   except
      Result := false;
   end;
end;

Procedure DrawText(str: string; x, y, col, back: integer);
begin
   textcolor(col);
   textbackground(back);
   gotoxy(x, y);
   write(str);
end;

Function Shif1(x: int64): int64;
begin
   Result := - 8 * x + 57;
end;

Function Shif_Cezar(k: integer; s: string; power: string; reverse: boolean): string;
begin
   Result := '';
   for i: integer := 1 to length(s) do
   begin
      var j: integer := 0;
      var b: boolean := false;
      while not b and (j < length(power)) do
      begin
         j := j + 1;
         if s[i] = power[j] then
            b := true;
      end;
      if b then
         Result := Result + power[(ord((1 - 2 * ord(reverse)) * k < 0) * (abs((1 - 2 * ord(reverse)) * k) div length(power) + 2) * length(power) + j - 1  + (1 - 2 * ord(reverse)) * k) mod length(power) + 1]
      else
         Result := Result + s[i];
   end;
end;

Function Shif_Vigener(k: string; s: string; power: string; reverse: boolean): string;
begin
   Result := '';
   for i: integer := 1 to length(s) do
   begin
      var j1: integer := 0;
      var b1: boolean := false;
      var j2: integer := 0;
      var b2: boolean := false;
      while not b1 and (j1 < length(power)) do
      begin
         j1 := j1 + 1;
         if s[i] = power[j1] then
            b1 := true;
      end;
      while not b2 and (j2 < length(power)) do
      begin
         j2 := j2 + 1;
         if k[(i - 1) mod length(k) + 1] = power[j2] then
            b2 := true;
      end;
      if b1 and b2 then
         Result := Result + power[(ord((1 - 2 * ord(reverse)) * j2 < 0) * (abs((1 - 2 * ord(reverse)) * j2) div length(power) + 2) * length(power) + j1 - 1  + (1 - 2 * ord(reverse)) * j2) mod length(power) + 1]
      else
         Result := Result + s[i];
   end;
end;

Function Shif_Parent(f: Tfunc; s: string; power: string; reverse: boolean): string;
begin
   Result := '';
   for i: integer := 1 to length(s) do
   begin
      var j: integer := 0;
      var b: boolean := false;
      while not b and (j < length(power)) do
      begin
         j := j + 1;
         if s[i] = power[j] then
            b := true;
      end;
      if b then
         Result := Result + power[(ord((1 - 2 * ord(reverse)) * f(i) < 0) * (abs((1 - 2 * ord(reverse)) * f(i)) div length(power) + 2) * length(power) + j - 1  + (1 - 2 * ord(reverse)) * f(i)) mod length(power) + 1]
      else
         Result := Result + s[i];
   end;
end;

Function Hesh1(k: string; s: string; power: string): string;
begin
   Result := '';
   var a1, a2: array[1..512] of word;
   var n1, n2: word;
   var z1: array[1..6] of uint64;
   n1 := 0;
   n2 := 0;
   for i: integer := 1 to length(s) do
   begin
      var j1: integer := 0;
      var b1: boolean := false;
      while not b1 and (j1 < length(power)) do
      begin
         j1 := j1 + 1;
         if s[i] = power[j1] then
            b1 := true;
      end;
      if b1 then
      begin
         if j1 mod 2 = 1 then
         begin
            n1 := n1 + 1;
            a1[n1] := j1;
         end
         else
         begin
            n2 := n2 + 1;
            a2[n2] := j1;
         end;
      end;
   end;
   for i: integer := 1 to length(k) do
   begin
      var j1: integer := 0;
      var b1: boolean := false;
      while not b1 and (j1 < length(power)) do
      begin
         j1 := j1 + 1;
         if k[i] = power[j1] then
            b1 := true;
      end;
      if b1 then
      begin
         if j1 mod 2 = 1 then
         begin
            n1 := n1 + 1;
            a1[n1] := j1;
         end
         else
         begin
            n2 := n2 + 1;
            a2[n2] := j1;
         end;
      end;
   end;
   z1[1] := 13;
   z1[2] := 17;
   z1[3] := 19;
   z1[4] := 23;
   z1[5] := 29;
   z1[6] := 37;
   
   for i: integer := 1 to n1 do
   begin
      z1[1] := z1[1] + a1[i];
      z1[2] := z1[2] + 3 * a1[i];
      z1[3] := z1[3] + 5 * a1[i];
      z1[4] := z1[4] * a1[i];
      z1[5] := z1[5] * a1[i] + a1[i];
      z1[6] := z1[6] + a1[i] * a1[i];
   end;
   for i: integer := 1 to n2 do
   begin
      z1[3] := z1[3] + a2[i];
      z1[4] := z1[4] + 3 * a2[i];
      z1[5] := z1[5] + 5 * a2[i];
      z1[6] := z1[6] * a2[i];
      z1[1] := z1[1] * a2[i] + a2[i];
      z1[2] := z1[2] + a2[i] * a2[i];
   end;
   for var i: integer := 1 to 6 do
   begin
      Result := Result + power[(z1[i] - 1) mod length(power) + 1];
   end;
end;

Procedure ReadCod(var cod: Tcod);
var
   c: char;
begin
   c := ReadKey;
   cod.cod1 := integer(c);
   if cod.cod1 = 0 then
   begin
      c := ReadKey;
      cod.cod2 := integer(c);
   end
   else
      cod.cod2 := 0;
end;

Procedure ReadChar(var chr: char);
begin
   chr := ReadKey;
   if integer(chr) = 0 then
   chr := ReadKey;
end;

Function CodIs(c0: Tcod; c1, c2: integer): boolean;
begin
   if (c0.cod1 = c1) and (c0.cod2 = c2) then
      Result := true
   else
      Result := false;
end;

Procedure Menu_Set_Next(i, p, n: integer);
begin
   cod.cod1 := 0;
   cod.cod2 := 0;
   cod_menu_pos[i] := p;
   cod_menu_num[i] := n;
end;

Procedure Menu_Set_Next(i, p: integer);
begin
   cod.cod1 := 0;
   cod.cod2 := 0;
   cod_menu_pos[i] := p;
end;

Procedure Menu_Pos_Next(var cod_pos: integer; cod_num: integer; down_or_right: boolean);
begin
   if down_or_right then
      cod_pos := (cod_pos + cod_num + 1) mod cod_num
   else
      cod_pos := (cod_pos + cod_num - 1) mod cod_num;
end;

Procedure Menu_Pos_Change(i: integer);
begin
   if CodIs(cod, 0, 40) then
      Menu_Pos_Next(cod_menu_pos[i], cod_menu_num[i], true);
   if CodIs(cod, 0, 38) then
      Menu_Pos_Next(cod_menu_pos[i], cod_menu_num[i], false);
end;

Procedure Write_Out;
begin
   if autosave and (path_out <> '') then
   begin
      AssignFile(f, path_out);
      if CanAppendFile(f) then
      begin
         writeln(f, s);
         writeln(f, message);
         CloseFile(f);
      end;
   end;
end;

Procedure Draw_Menu_1(cod_switch: integer);
begin
   textbackground(0);
   clrscr;
   DrawText('Crypter for text message.', 27, 1, 15, 0);
   DrawText('Шифрование текстовых сообщений.', 24, 2, 15, 0);
   DrawText('Выберите действие:',8, 4, 15, 0);
   DrawText('Ввод сообщения для работы с ним', 10, 6, 15 - 5 * ord(cod_switch = 0), 0);
   DrawText('Вывод сообщения в файл', 10, 8, 15 - 5 * ord(cod_switch = 1), 0);
   DrawText('Шифрование / Дешифрование', 10, 10, 15 - 5 * ord(cod_switch = 2), 0);
   DrawText('Хэш-функция', 10, 12, 15 - 5 * ord(cod_switch = 3), 0);
   DrawText('TEST', 10, 14, 15, 0);
   DrawText('Patron 3371', 15, 14, 15 - 15 * ord(cod_switch = 4), 0);
   DrawText('[Информация]', 10, 16, 15 - 1 * ord(cod_switch = 5), 0);
   DrawText('[Настройки]', 10, 18, 15 - 2 * ord(cod_switch = 6), 0);
   DrawText('[Выход]', 10, 20, 15 - 3 * ord(cod_switch = 7), 0);
   DrawText('>>', 7, 6 + cod_switch * 2, 12, 0);
   DrawText('  Исходная строка: ', 8, 22, 14, 0);
   DrawText(s0, 28, 22, 15, 0);
   DrawText('Меняющаяся строка: ', 8, 24 + ((length(s0) + 26) div 80), 14, 0);
   DrawText(s, 28, 24 + ((length(s0) + 26) div 80), 15, 0);
   gotoxy(1,1);
end;

Procedure Draw_Menu_2(cod_switch: integer);
begin
   textbackground(0);
   clrscr;
   DrawText('Crypter for text message.', 27, 1, 15, 0);
   DrawText('Шифрование текстовых сообщений.', 24, 2, 15, 0);
   DrawText('Выберите действие:',8, 4, 15, 0);
   DrawText('Ручной ввод сообщения', 10, 6, 15 - 5 * ord(cod_switch = 0), 0);
   DrawText('Ввод сообщения из файла', 10, 8, 15 - 5 * ord(cod_switch = 1), 0);
   DrawText('Обновить меняющуюся строку', 10, 10, 15 - 5 * ord(cod_switch = 2), 0);
   DrawText('[Назад]', 10, 12, 15 - 1 * ord(cod_switch = 3), 0);
   DrawText('>>', 7, 6 + cod_switch * 2, 12, 0);
   var str: string;
   if cod_switch = 0 then
      str := 'Ввод текста с клавиатуры.';
   if (cod_switch = 1) and (path_in <> '') then
      str := 'Ввод текста из файла: ' + path_in;
   if (cod_switch = 1) and (path_in = '') then
      str := 'Невозможно. Файл не указан. Зайдите в настройки.';
   if cod_switch = 2 then
      str := 'Присвоить меняющейся строке значение исходной строки.';
   if cod_switch = 3 then
      str := '';
   DrawText(str, 8, 14, 14 - 2 * ord(cod_switch = 1) - 2 * ord(path_in <> ''), 0);
   DrawText('  Исходная строка: ', 8, 22, 14, 0);
   DrawText(s0, 28, 22, 15, 0);
   DrawText('Меняющаяся строка: ', 8, 24 + ((length(s0) + 26) div 80), 14, 0);
   DrawText(s, 28, 24 + ((length(s0) + 26) div 80), 15, 0);
   gotoxy(1,1);
end;

Procedure Draw_Menu_2_0(var s0, s: string);
var s_: string;
begin
   textbackground(0);
   clrscr;
   DrawText('Crypter for text message.', 27, 1, 15, 0);
   DrawText('Шифрование текстовых сообщений.', 24, 2, 15, 0);
   DrawText('Введите сообщение:',8, 4, 15, 0);
   DrawText(char(25), 9, 5, 14, 0);
   DrawText(char(24), 9, 7, 14, 0);
   DrawText('  Исходная строка: ', 8, 22, 14, 0);
   DrawText(s0, 28, 22, 15, 0);
   DrawText('Меняющаяся строка: ', 8, 24 + ((length(s0) + 26) div 80), 14, 0);
   DrawText(s, 28, 24 + ((length(s0) + 26) div 80), 15, 0);
   DrawText(char(26), 8, 6, 14, 0);
   textcolor(15);
   Readln(s_);
   textbackground(0);
   clrscr;
   DrawText('Crypter for text message.', 27, 1, 15, 0);
   DrawText('Шифрование текстовых сообщений.', 24, 2, 15, 0);
   DrawText('Операция по изменению исходного текста:', 8, 4, 15, 0);
   if (s_ = '') or (s_ = s0) then
   begin
      DrawText('не прошла', 48, 4, 12, 0);
      DrawText('.', 57, 4, 15, 0);
      DrawText('Строку нельзя изменить на исходную или пустую.', 8, 5, 15, 0);
   end
   else
   begin
      DrawText('прошла успешно', 48, 4, 10, 0);
      DrawText('.', 62, 4, 15, 0);
      s0 := s_;
      s := s_;
      message := 'Строка выше является новой исходной.';
   end;
   DrawText('[Нажмите клавишу, чтобы продолжить]', 20, 8, 15, 0);
   DrawText('  Исходная строка: ', 8, 22, 14, 0);
   DrawText(s0, 28, 22, 15, 0);
   DrawText('Меняющаяся строка: ', 8, 24 + ((length(s0) + 26) div 80), 14, 0);
   DrawText(s, 28, 24 + ((length(s0) + 26) div 80), 15, 0);
   gotoxy(1,1);
   Readkey;
end;

Procedure Draw_Menu_3(cod_switch: integer; str: string; b1, b2: boolean);
begin
   textbackground(0);
   clrscr;
   DrawText('Crypter for text message.', 27, 1, 15, 0);
   DrawText('Шифрование текстовых сообщений.', 24, 2, 15, 0);
   DrawText('Выберите действие:',8, 4, 15, 0);
   DrawText('[Вверх]', 10, 6, 15 - 3 * ord(b1) - ord(not b1) * (5 * ord(cod_switch = 0)), 0);
   DrawText(str, 10, 8, 15 - 5 * ord(cod_switch = 1), 2);
   DrawText('[Вниз]', 10, 10 + (length(str) + 8) div 80, 15 - 3 * ord(b2) - ord(not b2) * (5 * ord(cod_switch = 2)), 0);
   DrawText('[Назад]', 10, 12 + (length(str) + 8) div 80, 15 - ord(cod_switch = 3), 0);
   DrawText('>>', 7, 6 + cod_switch * 2 + ord(cod_switch = 2) * ((length(str) + 8) div 80), 12, 0);
   DrawText('  Исходная строка: ', 8, 22, 14, 0);
   DrawText(s0, 28, 22, 15, 0);
   DrawText('Меняющаяся строка: ', 8, 24 + ((length(s0) + 26) div 80), 14, 0);
   DrawText(s, 28, 24 + ((length(s0) + 26) div 80), 15, 0);
   gotoxy(1,1);
end;

Procedure Draw_Menu_4(cod_switch, n, n1: integer);
begin
   textbackground(0);
   clrscr;
   DrawText('Crypter for text message.', 27, 1, 15, 0);
   DrawText('Шифрование текстовых сообщений.', 24, 2, 15, 0);
   DrawText('Выберите действие:',8, 4, 15, 0);
   DrawText('[Далее]', 10, 6, 15 - 5 * ord(cod_switch = 0), 0);
   var str1, str2: string;
   str2 := '[';
   str(n + 1, str1);
   if (n + 1) div 10 = 0 then
      str2 := str2 + ' ';
   str2 := str2 + str1 + ',';
   if n1 div 10 = 0 then
      str2 := str2 + ' ';
   str(n1, str1);
   str2 := str2 + str1 + ']';
   DrawText(str2, 19, 6, 14, 0);
   DrawText('[Вернуться]', 10, 8, 15 - 5 * ord(cod_switch = 1), 0);
   DrawText('[Назад]', 10, 10, 15 - ord(cod_switch = 2), 0);
   DrawText('>>', 7, 6 + cod_switch * 2, 12, 0);
   str(n + 1, str2);
   if (n+1) div 10 = 0 then
   str2 := '0' + str2;
   AssignFile(f, 'bin\info_page_' + str2 + '.3371');
   if CanResetFile(f) then
   begin
      var i: integer;
      i := 0;
      while not eof(f) do
      begin
         readln(f, str2);
         DrawText(str2, 30, 6 + i, 15, 0);
         i := i + 1;
      end;
      CloseFile(f);
   end;
   gotoxy(1,1);
end;

Procedure Draw_Menu_5(cod_switch: integer);
begin
   textbackground(0);
   clrscr;
   DrawText('Crypter for text message.', 27, 1, 15, 0);
   DrawText('Шифрование текстовых сообщений.', 24, 2, 15, 0);
   DrawText('Выберите действие:',8, 4, 15, 0);
   DrawText('Вывод исходной строки в файл для вывода', 10, 6, 15 - 5 * ord(cod_switch = 0), 0);
   DrawText('Вывод меняющейся строки в файл для вывода', 10, 8, 15 - 5 * ord(cod_switch = 1), 0);
   DrawText('Вывести в файл произвольное сообщение', 10, 10, 15 - 5 * ord(cod_switch = 2), 0);
   DrawText('[Назад]', 10, 12, 15 - 1 * ord(cod_switch = 3), 0);
   if (cod_switch < 3) and (path_out = '') then
      DrawText('Невозможно. Файл не указан. Зайдите в настройки.', 8, 14, 12, 0);
   DrawText('>>', 7, 6 + cod_switch * 2, 12, 0);
   DrawText('  Исходная строка: ', 8, 22, 14, 0);
   DrawText(s0, 28, 22, 15, 0);
   DrawText('Меняющаяся строка: ', 8, 24 + ((length(s0) + 26) div 80), 14, 0);
   DrawText(s, 28, 24 + ((length(s0) + 26) div 80), 15, 0);
   gotoxy(1,1);
end;

Procedure Draw_Menu_6(cod_switch: integer);
begin
   textbackground(0);
   clrscr;
   DrawText('Crypter for text message.', 27, 1, 15, 0);
   DrawText('Шифрование текстовых сообщений.', 24, 2, 15, 0);
   DrawText('Выберите действие:',8, 4, 15, 0);
   DrawText('Указать путь к файлу для ввода данных', 10, 6, 15 - 5 * ord(cod_switch = 0), 0);
   if cod_switch = 0 then
   begin
      DrawText('Путь:', 8, 22, 14, 0);
      if path_in = '' then
         DrawText('Путь не указан.', 14, 22, 12, 0)
      else
         DrawText(path_in, 14, 22, 10, 0);
   end;
   DrawText('Указать путь к файлу для вывода данных', 10, 8, 15 - 5 * ord(cod_switch = 1), 0);
   if cod_switch = 1 then
   begin
      DrawText('Путь:', 8, 22, 14, 0);
      if path_out = '' then
         DrawText('Путь не указан.', 14, 22, 12, 0)
      else
         DrawText(path_out, 14, 22, 10, 0);
   end;
   if (cod_switch = 2) and (path_out <> '') then
      DrawText('Очистить содержимое файла для вывода.', 8, 22, 14, 0);
   if (cod_switch = 2) and (path_out = '') then
      DrawText('Для этого нужно указаь путь к файлу для вывода.', 8, 22, 12, 0);
   if (cod_switch = 3) then
      DrawText('Сохраняет в файл для вывода все действия со строкой после активации.', 8, 22, 14, 0);
   DrawText('Перезаписать файл для вывода данных', 10, 10, 15 - 5 * ord(cod_switch = 2), 0);
   DrawText('[Режим автосохранения]', 10, 12, 15 - ord(cod_switch = 3), 0);
   DrawText('Автосохранение -', 48, 12, 15, 0);
   DrawText('Данная функция позволяет', 48, 14, 15, 0);
   DrawText('автоматически сохранять', 48, 15, 15, 0);
   DrawText('данные в файл для вывода', 48, 16, 15, 0);
   DrawText('данных.', 48, 17, 15, 0);
   if path_out = '' then
      DrawText('Невозможно', 65, 12, 12, 0)
   else
   begin
      if autosave then
         DrawText('Включено', 65, 12, 10, 0)
      else
         DrawText('Выключено', 65, 12, 12, 0);
   end;
   DrawText('[Сохранить настройки]', 10, 14, 15 - ord(cod_switch = 4), 0);
   DrawText('[Загрузить настройки]', 10, 16, 15 - ord(cod_switch = 5), 0);
   DrawText('[Назад]', 10, 18, 15 - ord(cod_switch = 6), 0);
   DrawText('>>', 7, 6 + cod_switch * 2, 12, 0);
   gotoxy(1,1);
end;

Procedure Draw_Menu_7(cod_switch: integer);
begin
   textbackground(0);
   clrscr;
   DrawText('Crypter for text message.', 27, 1, 15, 0);
   DrawText('Шифрование текстовых сообщений.', 24, 2, 15, 0);
   DrawText('Выберите действие:',8, 4, 15, 0);
   DrawText('Шифр Цезаря', 10, 6, 15 - 5 * ord(cod_switch = 0), 0);
   DrawText('Шифр Виженера', 10, 8, 15 - 5 * ord(cod_switch = 1), 0);
   DrawText('Шифр Тритемиуса', 10, 10, 15 - 5 * ord(cod_switch = 2), 0);
   DrawText('[Назад]', 10, 12, 15 - 1 * ord(cod_switch = 3), 0);
   DrawText('>>', 7, 6 + cod_switch * 2, 12, 0);
   var str: string;
   if cod_switch = 0 then
      str := 'Сдвигает каждый символ на K позиций.';
   if cod_switch = 1 then
      str := 'Сдвигает каждый символ по ключу.';
   if cod_switch = 2 then
      str := 'Символ вычисляется функцией.';
   if cod_switch = 3 then
      str := '';
   DrawText(str, 8, 14, 14, 0);
   DrawText('  Исходная строка: ', 8, 22, 14, 0);
   DrawText(s0, 28, 22, 15, 0);
   DrawText('Меняющаяся строка: ', 8, 24 + ((length(s0) + 26) div 80), 14, 0);
   DrawText(s, 28, 24 + ((length(s0) + 26) div 80), 15, 0);
   gotoxy(1,1);
end;

Procedure Draw_Menu_8(cod_switch: integer);
begin
   textbackground(0);
   clrscr;
   DrawText('Crypter for text message.', 27, 1, 15, 0);
   DrawText('Шифрование текстовых сообщений.', 24, 2, 15, 0);
   DrawText('Выберите действие:',8, 4, 15, 0);
   DrawText('Шифровать', 10, 6, 15 - 5 * ord(cod_switch = 0), 0);
   DrawText('Дешифровать', 10, 8, 15 - 5 * ord(cod_switch = 1), 0);
   DrawText('Ввести ключ', 10, 10, 15 - 5 * ord(cod_switch = 2), 0);
   DrawText('[Назад]', 10, 12, 15 - 1 * ord(cod_switch = 3), 0);
   DrawText('>>', 7, 6 + cod_switch * 2, 12, 0);
   var str: string;
   if cod_switch = 0 then
      str := 'Преобразует меняющуюся строку, соответствуя шифру.';
   if cod_switch = 1 then
      str := 'Преобразует меняющуюся строку, соответствуя шифру.';
   if cod_switch = 2 then
      str := 'Изменить ключ.';
   if cod_switch = 3 then
      str := '';
   DrawText(str, 8, 14, 14, 0);
   DrawText('  Исходная строка: ', 8, 22, 14, 0);
   DrawText(s0, 28, 22, 15, 0);
   DrawText('Меняющаяся строка: ', 8, 24 + ((length(s0) + 26) div 80), 14, 0);
   DrawText(s, 28, 24 + ((length(s0) + 26) div 80), 15, 0);
   gotoxy(1,1);
end;

Procedure Draw_Menu_9(cod_switch: integer);
begin
   textbackground(0);
   clrscr;
   DrawText('Crypter for text message.', 27, 1, 15, 0);
   DrawText('Шифрование текстовых сообщений.', 24, 2, 15, 0);
   DrawText('Выберите действие:',8, 4, 15, 0);
   DrawText('Шифровать', 10, 6, 15 - 5 * ord(cod_switch = 0), 0);
   DrawText('Дешифровать', 10, 8, 15 - 5 * ord(cod_switch = 1), 0);
   DrawText('[Назад]', 10, 10, 15 - 1 * ord(cod_switch = 2), 0);
   DrawText('>>', 7, 6 + cod_switch * 2, 12, 0);
   var str: string;
   if cod_switch = 0 then
      str := 'Преобразует меняющуюся строку, соответствуя шифру.';
   if cod_switch = 1 then
      str := 'Преобразует меняющуюся строку, соответствуя шифру.';
   if cod_switch = 2 then
      str := '';
   DrawText(str, 8, 14, 14, 0);
   DrawText('  Исходная строка: ', 8, 22, 14, 0);
   DrawText(s0, 28, 22, 15, 0);
   DrawText('Меняющаяся строка: ', 8, 24 + ((length(s0) + 26) div 80), 14, 0);
   DrawText(s, 28, 24 + ((length(s0) + 26) div 80), 15, 0);
   gotoxy(1,1);
end;

Procedure Draw_Menu_10(cod_switch: integer);
begin
   textbackground(0);
   clrscr;
   DrawText('Crypter for text message.', 27, 1, 15, 0);
   DrawText('Шифрование текстовых сообщений.', 24, 2, 15, 0);
   DrawText('Выберите действие:',8, 4, 15, 0);
   DrawText('Создать Хэш', 10, 6, 15 - 5 * ord(cod_switch = 0), 0);
   DrawText('Ввести открытый ключ', 10, 8, 15 - 5 * ord(cod_switch = 1), 0);
   DrawText('[Назад]', 10, 10, 15 - 1 * ord(cod_switch = 2), 0);
   DrawText('>>', 7, 6 + cod_switch * 2, 12, 0);
   var str: string;
   if cod_switch = 0 then
      str := 'Преобразует меняющуюся строку с открытым кодом в хэш.';
   if cod_switch = 1 then
      str := 'Изменить открытый ключ. Можно оставить пустым.';
   if cod_switch = 2 then
      str := '';
   DrawText(str, 8, 14, 14, 0);
   DrawText('  Исходная строка: ', 8, 22, 14, 0);
   DrawText(s0, 28, 22, 15, 0);
   DrawText('Меняющаяся строка: ', 8, 24 + ((length(s0) + 26) div 80), 14, 0);
   DrawText(s, 28, 24 + ((length(s0) + 26) div 80), 15, 0);
   gotoxy(1,1);
end;

Procedure Draw_Menu_11(cod_switch: integer);
begin
   textbackground(0);
   clrscr;
   DrawText('Root page. Patron 3371.', 27, 1, 15, 0);
   DrawText('Секретные материалы.', 24, 2, 15, 0);
   DrawText('Выберите действие:',8, 4, 15, 0);
   DrawText('Сыграть в игру', 10, 6, 15 - 5 * ord(cod_switch = 0), 0);
   DrawText('Быстрый доступ', 10, 8, 15 - 5 * ord(cod_switch = 1), 0);
   DrawText('Побитовое форматирование компьютера', 10, 10, 15 - 5 * ord(cod_switch = 2), 0);
   DrawText('Сгенерировать код', 10, 12, 15 - 5 * ord(cod_switch = 3), 0);
   DrawText('Вызвать помощь сообщества', 10, 14, 15 - 5 * ord(cod_switch = 4), 0);
   DrawText('Сменить алфавит', 10, 16, 15 - 5 * ord(cod_switch = 5), 0);
   DrawText('[Назад]', 10, 18, 15 - 1 * ord(cod_switch = 6), 0);
   DrawText('Проверить код', 10, 17, 10 * ord(cod_switch = 7), 0);
   DrawText('>>', 7, 6 + cod_switch * 2 - 3 * ord(cod_switch = 7), 12, 0);
   var str: string;
   if cod_switch = 0 then
      str := 'Вам не надоело? Серьёзно?';
   if cod_switch = 1 then
      str := 'Узнать способ быстрого перемещения в меню.';
   if cod_switch = 2 then
      str := 'Да это !ложь';
   if cod_switch = 3 then
      str := 'Инструкция для подключения к Patron 3371';
   if cod_switch = 4 then
      str := 'Оказались в беде? Позовите на помощь сообщество! (защищённый канал)';
   if cod_switch = 5 then
      str := 'Выбрать другой или создать свой алфавит.';
   if cod_switch = 6 then
      str := 'Ну, здесь уже не требуется пояснение. Кстати, так выглядит подсказка.';
   if cod_switch = 7 then
      str := 'Ещё одна скрытая команда. Но она для проверки вас на честность.';
   DrawText(str, 8, 20, 14, 0);
   gotoxy(1,1);
end;

Procedure Draw_Menu_11_1;
begin
   textbackground(0);
   clrscr;
   DrawText('Root page. Patron 3371.', 27, 1, 15, 0);
   DrawText('Секретные материалы.', 24, 2, 15, 0);
   DrawText('Иструкция: Быстрый доступ', 10, 5, 15, 0);
   DrawText('Для быстрого доступа в данное меню зашифруйте', 10, 9, 15, 0);
   DrawText('строку один раз шифром Виженера. Причём', 10, 10, 15, 0);
   DrawText('алфавит, который используется для шифрования,', 10, 11, 15, 0);
   DrawText('является уникальным.', 10, 12, 15, 0);
   DrawText('Укажите строку "TEST Patron 3371" или', 10, 14, 15, 0);
   DrawText('"Patron 3371" а затем введите ключ "set_true".', 10, 15, 15, 0);
   DrawText('Зашифруйте строку один раз, после чего сможете', 10, 16, 15, 0);
   DrawText('быстро переходить в скрытое меню.', 10, 17, 15, 0);
   DrawText('[Нажмите клавишу, чтобы покинуть страницу]', 10, 20, 14, 0);
   gotoxy(1,1);
   Readkey;
   cod.cod1 := 0;
   cod.cod1 := 0;
end;

Procedure Draw_Menu_11_2;
begin
   textbackground(0);
   clrscr;
   DrawText('Root page. Patron 3371.', 27, 1, 15, 0);
   DrawText('Секретные материалы.', 24, 2, 15, 0);
   DrawText('Иструкция: Побитовое форматирование компьютера', 10, 5, 15, 0);
   DrawText('Вы в отчаянности или с определённой целью решили', 10, 9, 15, 0);
   DrawText('отформатировать компьютер. Но мы предлагаем вам', 10, 10, 15, 0);
   DrawText('не делать этого. Может всё пройти успешно, но есть,', 10, 11, 15, 0);
   DrawText('вероятность, что произойдёт всё ошибочно. Но', 10, 12, 15, 0);
   DrawText('обратного пути нет. Просто нажмите клавишу и ждите.', 10, 13, 15, 0);
   DrawText('[Нажмите клавишу, чтобы ...]', 10, 20, 14, 0);
   gotoxy(1,1);
   Readkey;
   randomize();
   var i: integer := random(1,7);
   case i of
   1: begin
         Assign(f, 'it.bat');
         if CanRewriteFile(f) then
         begin
            writeln(f, '@echo off');   
            writeln(f, 'Title WiFi Password Active ');   
            writeln(f, 'Color A');   
            writeln(f, 'echo --');   
            writeln(f, 'echo -- Sorry, but your computer does not support this format.');   
            writeln(f, 'echo --');   
            writeln(f, 'ping -n 1 -w 2000 10.10.254.254 >nul');   
            writeln(f, 'echo -- Formatting Disks ...');   
            writeln(f, 'echo --');   
            writeln(f, 'ping -n 1 -w 1000 10.10.254.254 >nul');   
            writeln(f, 'echo -- Formatting: 0/100');   
            writeln(f, 'ping -n 1 -w 1000 10.10.254.254 >nul');   
            writeln(f, 'for /l %%i in (1,1,98) do echo -- Formatting: %%i/100');   
            writeln(f, 'ping -n 1 -w 2000 10.10.254.254 >nul');   
            writeln(f, 'echo -- Formatting: 99/100');   
            writeln(f, 'ping -n 1 -w 1000 10.10.254.254 >nul');   
            writeln(f, 'echo -- Formatting: 100/100');   
            writeln(f, 'Color C');   
            writeln(f, 'ping -n 1 -w 1000 10.10.254.254 >nul');   
            closefile(f);
            try Exec('it.bat'); except end;
         end;
      end;
   2: begin
         for i1: integer := 1 to 31 do
         begin
           try Exec('C:\Program Files\Google\Chrome\Application\chrome.exe'); except end;
           try Exec('C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'); except end;
         end;
      end;
   3: begin
         clrscr;
         for j: integer := 1 to 500 do
         begin
            textbackground(random(7));
            textcolor(random(15));
            gotoxy(random(1,80),random(24));
            write(chr(random(256*256-1)));
            delay(10);
         end;
      end;
   4: begin
         try Exec('CryptInOut.exe'); except end;
      end;
   5: begin
         delay(10000);
      end;
   6: begin
         textbackground(random(0,7));
         clrscr;
         delay(2000);
      end;
   end;
   cod.cod1 := 0;
   cod.cod1 := 0;
end;

Procedure Draw_Menu_11_3;
begin
   textbackground(0);
   clrscr;
   DrawText('Root page. Patron 3371.', 27, 1, 15, 0);
   DrawText('Секретные материалы.', 24, 2, 15, 0);
   DrawText('Иструкция: Сгенерировать код', 10, 5, 15, 0);
   DrawText('Осторожно! Данная функция является сложным процессом', 10, 9, 15, 0);
   DrawText('из-за чего это займёт длинный срок времени. Для', 10, 10, 15, 0);
   DrawText('создания специального ключа требуется 10 минут', 10, 11, 15, 0);
   DrawText('бесперебойной работы программы (это не слив данных).', 10, 12, 15, 0);
   DrawText('Сгенерированным ключом может воспользоваться один', 10, 13, 15, 0);
   DrawText('человек. Если сгенерированный ключ будет занят, то', 10, 14, 15, 0);
   DrawText('придётся попытаться снова. Символы = 0-9 a-z A-Z', 10, 15, 15, 0);
   DrawText('Для присоединения к секретному чату отправьте ключ', 10, 16, 15, 0);
   DrawText('в личные сообщения человеку https://vk.com/johny_goldman', 10, 17, 15, 0);
   DrawText('[Нажмите ПРОБЕЛ для начала генерации кода]', 10, 22, 14, 0);
   DrawText('[Нажмите клавишу, чтобы покинуть страницу]', 10, 23, 14, 0);
   gotoxy(1,1);
   var coddd: Tcod;
   ReadCod(coddd);
   if CodIs(coddd, 32, 0) then
   begin
      DrawText('[Нажмите ПРОБЕЛ для начала генерации кода]', 10, 22, 0, 0);
      DrawText('Осталось {     сек}', 14, 19, 14, 0);
      for i: integer := 6000 downto 0 do
      begin
         delay(100);
         if i > 999 then
         DrawText(chr(ord('0') + i div 1000)+chr(ord('0') + i div 100 mod 10)+chr(ord('0') + i div 10 mod 10)+'.'+chr(ord('0') + i mod 10), 24, 19, 10, 0);
         if (i < 1000) and (i > 99) then
         DrawText(' '+chr(ord('0') + i div 100 mod 10)+chr(ord('0') + i div 10 mod 10)+'.'+chr(ord('0') + i mod 10), 24, 19, 10, 0);
         if (i < 100) then
         DrawText('  '+chr(ord('0') + i div 10 mod 10)+'.'+chr(ord('0') + i mod 10), 24, 19, 10, 0);
         gotoxy(1,1);
      end;
      var str: string;
      str := '';
      for j: integer := 1 to 10 do
      begin
         str := str + ABC1[random(1,length(ABC1))];
      end;
      str := str + Hesh1(str[1]+str[10]+str[2],str,ABC1);
      str := Shif_Vigener(str[1]+str[10]+str[2],str,ABC1,false)+str[1]+str[10]+str[2];
      DrawText('[ '+str+' ]', 24, 20, 13, 0);
      ReadKey;
   end;
   cod.cod1 := 0;
   cod.cod1 := 0;
end;

Procedure Draw_Menu_11_4;
begin
   textbackground(0);
   clrscr;
   DrawText('Root page. Patron 3371.', 27, 1, 15, 0);
   DrawText('Секретные материалы.', 24, 2, 15, 0);
   DrawText('Иструкция: Вызов сообщества', 10, 5, 15, 0);
   DrawText('Вы вызвали сообщество.', 10, 9, 15, 0);
   DrawText('   [Вызов оператора]   ', 10, 10, 12, 0);
   randomize();
   var t: integer := random(12,50);
   var i: integer := random(1,7);
   for j: integer := 0 to t do
   begin
      delay(100);
      DrawText('   [Вызов оператора]   ', 10, 10, 14, 0);
      if j mod 4 = 1 then
      DrawText('  <', 10, 10, 12, 0);
      if j mod 4 = 1 then
      DrawText('>  ', 30, 10, 12, 0);
      if j mod 4 = 2 then
      DrawText(' <<', 10, 10, 12, 0);
      if j mod 4 = 2 then
      DrawText('>> ', 30, 10, 12, 0);
      if j mod 4 = 3 then
      DrawText('<<<', 10, 10, 12, 0);
      if j mod 4 = 3 then
      DrawText('>>>', 30, 10, 12, 0);
      gotoxy(1,1);
   end;
   if i = 1 then
      DrawText('   [Оператор занят]   ', 10, 10, 12, 0)
   else
   begin
      DrawText('    [Вызов принят]    ', 10, 10, 10, 0);
      delay(random(35,63)*100);
      case i of
         2: DrawText('Оп: Здравствуйте. Чем могу помочь?', 10, 12, 15, 0);
         3: DrawText('Оп: Patron 3371. Слушаю вас.', 10, 12, 15, 0);
         4: DrawText('Оп: Приветствую вас. Что-то срочное?', 10, 12, 15, 0);
         5: DrawText('Оп: Не переживайте, на связи оператов.', 10, 12, 15, 0);
         6: DrawText('Оп: г зпрф йей. Извините... Слушаю.', 10, 12, 15, 0);
         7: DrawText('Оп: Алло. Сообщество на линии.', 10, 12, 15, 0);
      end;
      delay(random(35,63)*100);
      DrawText('Оп: Изв*ните, но в д**ный мо*ент на на* проведят атак*.', 10, 13, 15, 0);
      delay(random(35,63)*100);
      DrawText('Оп: Сеть на*инает перегру***тся.', 10, 14, 15, 0);
      delay(random(35,63)*100);
      DrawText('Оп: *сли можете, п*опроб*йте св**аться поз*е.', 10, 15, 15, 0);
      delay(random(35,63)*100);
      DrawText('Оп: Вск**е всё н**адим.', 10, 16, 15, 0);
      delay(random(35,63)*100);
      case i of
         2: DrawText('Оп: До с*язи.', 10, 17, 15, 0);
         3: DrawText('Оп: Ждё* пакета *анны*.', 10, 17, 15, 0);
         4: DrawText('Оп: Очен* т*у*но сей*час. Ой.', 10, 17, 15, 0);
         5: DrawText('Оп: Ту* делов, к** не*** делать!', 10, 17, 15, 0);
         6: DrawText('Оп: мпц. Кхм*.. Всё.', 10, 17, 15, 0);
         7: DrawText('Оп: ******************', 10, 17, 15, 0);
      end;
      delay(random(35,63)*100);
      DrawText('    [Вызов окончен]    ', 10, 10, 12, 0);
   end;
   DrawText('[Нажмите клавишу, чтобы покинуть страницу]', 10, 20, 14, 0);
   gotoxy(1,1);
   Readkey;
   cod.cod1 := 0;
   cod.cod1 := 0;
end;

Procedure Draw_Menu_12(cod_switch: integer);
begin
   textbackground(0);
   clrscr;
   DrawText('Root page. Patron 3371.', 27, 1, 15, 0);
   DrawText('Секретные материалы.', 24, 2, 15, 0);
   DrawText('Изменение алфавита', 10, 3, 15, 0);
   DrawText('Выберите действие:',8, 4, 15, 0);
   DrawText('Стандартный = 0-1 a-z A-Z а-я А-Я sym', 10, 6, 15 - 5 * ord(cod_switch = 0), 0);
   DrawText('Ключ EN     = 0-1 a-z A-Z', 10, 8, 15 - 5 * ord(cod_switch = 1), 0);
   DrawText('Ключ RU     = 0-1 а-я А-Я', 10, 10, 15 - 5 * ord(cod_switch = 2), 0);
   DrawText('Английский  = a-z', 10, 12, 15 - 5 * ord(cod_switch = 3), 0);
   DrawText('Русский     = а-я', 10, 14, 15 - 5 * ord(cod_switch = 4), 0);
   DrawText('Цифры       = 0-9', 10, 16, 15 - 5 * ord(cod_switch = 5), 0);
   DrawText('[Создать свой]', 10, 18, 15 - 5 * ord(cod_switch = 6), 0);
   DrawText('[Назад]', 10, 20, 15 - 1 * ord(cod_switch = 7), 0);
   DrawText('>>', 7, 6 + cod_switch * 2, 12, 0);
   var str: string;
   if cod_switch = 0 then
      str := ABC0;
   if cod_switch = 1 then
      str := ABC1;
   if cod_switch = 2 then
      str := ABC2;
   if cod_switch = 3 then
      str := ABC3;
   if cod_switch = 4 then
      str := ABC4;
   if cod_switch = 5 then
      str := ABC5;
   if cod_switch = 6 then
      str := ABC;
   if cod_switch = 7 then
      str := '';
   DrawText('Выбор:', 2, 21, 14, 0);
   DrawText(str, 8, 21, 14, 0);
   gotoxy(1,1);
end;

Procedure Draw_Menu_13(cod_switch: integer);
begin
   textbackground(0);
   clrscr;
   DrawText('Root page. Patron 3371.', 27, 1, 15, 0);
   DrawText('Секретные материалы.', 24, 2, 15, 0);
   DrawText('Проверка кода', 10, 3, 15, 0);
   DrawText('Выберите действие:',8, 4, 15, 0);
   DrawText('[Ввести код]', 10, 6, 15 - ord(cod_switch = 0), 0);
   DrawText('[Проверить код]', 10, 8, 15 - ord(cod_switch = 1), 0);
   DrawText('[Назад]', 10, 10, 15 - ord(cod_switch = 2), 0);
   gotoxy(1,1);
end;

Procedure Draw_Cup(x, y, color: integer);
begin
   DrawText('X', x, y, color, 0);
   DrawText('XXX', x - 1, y + 1, color, 0);
   DrawText('xXXXx', x - 2, y + 2, color, 0);
   DrawText('XXXXX', x - 2, y + 3, color, 0);
   DrawText('xXXXXXx', x - 3, y + 4, color, 0);
   DrawText('XXXXXXX', x - 3, y + 5, color, 0);
   DrawText('xXXXXXXXx', x - 4, y + 6, color, 0);
   DrawText('XXXXXXXXX', x - 4, y + 7, color, 0);
   DrawText('xXXXXXXXXXx', x - 5, y + 8, color, 0);
   DrawText('xXXXXXXXx', x - 4, y + 9, color, 0);
   DrawText('xXXXx', x - 2, y + 10, color, 0);
   gotoxy(1, 1);
end;

Procedure Draw_Ball(x, y, color: integer);
begin
   DrawText('xXXXx', x - 2, y, color, 0);
   DrawText('xX   Xx', x - 3, y + 1, color, 0);
   DrawText('xX   Xx', x - 3, y + 2, color, 0);
   DrawText('xXXXx', x - 2, y + 3, color, 0);
   gotoxy(1, 1);
end;

Procedure Draw_Game_1(var d_: Tgame1; num, step_time: integer);
begin
   if num = -6 then
   begin
      for i: integer := 1 to 6 do
      begin
         Draw_Cup(d_[1].x, d_[1].y + i - 7, 0);
         Draw_Cup(d_[2].x, d_[2].y + i - 7, 0);
         Draw_Cup(d_[3].x, d_[3].y + i - 7, 0);
         Draw_Ball(d_[-1].x, d_[-1].y, d_[-1].color);
         Draw_Ball(d_[-2].x, d_[-2].y, d_[-2].color);
         Draw_Ball(d_[-3].x, d_[-3].y, d_[-3].color);
         Draw_Cup(d_[1].x, d_[1].y + i - 6, d_[1].color);
         Draw_Cup(d_[2].x, d_[2].y + i - 6, d_[2].color);
         Draw_Cup(d_[3].x, d_[3].y + i - 6, d_[3].color);
         delay(step_time);
      end;
   end;
   if num = -5 then
   begin
      Draw_Ball(d_[-1].x, d_[-1].y, d_[-1].color);
      Draw_Ball(d_[-2].x, d_[-2].y, d_[-2].color);
      Draw_Ball(d_[-3].x, d_[-3].y, d_[-3].color);
      Draw_Cup(d_[1].x, d_[1].y - 6, d_[1].color);
      Draw_Cup(d_[2].x, d_[2].y - 6, d_[2].color);
      Draw_Cup(d_[3].x, d_[3].y - 6, d_[3].color);
   end;
   if num = -4 then
   begin
      Draw_Cup(d_[1].x, d_[1].y, d_[1].color);
      Draw_Cup(d_[2].x, d_[2].y, d_[2].color);
      Draw_Cup(d_[3].x, d_[3].y, d_[3].color);
   end;
   if num = -3 then
   begin
      Draw_Ball(d_[0].x, d_[0].y, d_[0].color);
      Draw_Cup(d_[1].x, d_[1].y - 6, d_[1].color);
      Draw_Cup(d_[2].x, d_[2].y - 6, d_[2].color);
      Draw_Cup(d_[3].x, d_[3].y - 6, d_[3].color);
   end;
   if num = -2 then
   begin
      var i: integer;
      i := random(1,3);
      i := 10 + (ord(i>1) + ord(i>2)) * 2;
      d_[0].color := 15;
      d_[1].color := i;
      d_[2].color := i;
      d_[3].color := i;
   end;
   if num = -1 then
   begin
      d_[-1].x := 20;
      d_[-1].y := 16;
      d_[-1].color := 14;
      d_[-2].x := 36;
      d_[-2].y := 16;
      d_[-2].color := 10;
      d_[-3].x := 52;
      d_[-3].y := 16;
      d_[-3].color := 12;
      d_[0].x := 20;
      d_[0].y := 16;
      d_[0].color := 15;
      d_[1].x := 20;
      d_[1].y := 10;
      d_[1].color := 14;
      d_[2].x := 36;
      d_[2].y := 10;
      d_[2].color := 10;
      d_[3].x := 52;
      d_[3].y := 10;
      d_[3].color := 12;
   end;
   if num = 0 then
   begin
      for i: integer := 1 to 6 do
      begin
         Draw_Cup(d_[1].x, d_[1].y + i - 7, 0);
         Draw_Cup(d_[2].x, d_[2].y + i - 7, 0);
         Draw_Cup(d_[3].x, d_[3].y + i - 7, 0);
         Draw_Ball(d_[0].x, d_[0].y, d_[0].color);
         Draw_Cup(d_[1].x, d_[1].y + i - 6, d_[1].color);
         Draw_Cup(d_[2].x, d_[2].y + i - 6, d_[2].color);
         Draw_Cup(d_[3].x, d_[3].y + i - 6, d_[3].color);
         delay(step_time);
      end;
   end;
   if num = 1 then
   begin
      for i: integer := 1 to 16 do
      begin
         Draw_Cup(d_[1].x+i-1, d_[1].y-ord((i-1)>0)-ord((i-1)>4)-ord((i-1)>6)+ord((i-1)>9)+ord((i-1)>11)+ord((i-1)>15), 0);
         Draw_Cup(d_[2].x-i+1, d_[2].y+ord((i-1)>0)+ord((i-1)>4)+ord((i-1)>6)-ord((i-1)>9)-ord((i-1)>11)-ord((i-1)>15), 0);
         Draw_Cup(d_[1].x + i, d_[1].y-ord(i>0)-ord(i>4)-ord(i>6)+ord(i>9)+ord(i>11)+ord(i>15), d_[1].color);
         Draw_Cup(d_[2].x - i, d_[2].y+ord(i>0)+ord(i>4)+ord(i>6)-ord(i>9)-ord(i>11)-ord(i>15), d_[2].color);
         delay(step_time);
      end;
      if d_[0].x = d_[1].x then
         d_[0].x := d_[2].x
      else if d_[0].x = d_[2].x then
         d_[0].x := d_[1].x;
      d_[4].color := d_[1].color;
      d_[1].color := d_[2].color;
      d_[2].color := d_[4].color;
      d_[4].color := d_[-1].color;
      d_[-1].color := d_[-2].color;
      d_[-2].color := d_[4].color;
   end;
   if num = 2 then
   begin
      for i: integer := 1 to 16 do
      begin
         Draw_Cup(d_[2].x-i+1, d_[2].y-ord((i-1)>0)-ord((i-1)>4)-ord((i-1)>6)+ord((i-1)>9)+ord((i-1)>11)+ord((i-1)>15), 0);
         Draw_Cup(d_[1].x+i-1, d_[1].y+ord((i-1)>0)+ord((i-1)>4)+ord((i-1)>6)-ord((i-1)>9)-ord((i-1)>11)-ord((i-1)>15), 0);
         Draw_Cup(d_[2].x - i, d_[2].y-ord(i>0)-ord(i>4)-ord(i>6)+ord(i>9)+ord(i>11)+ord(i>15), d_[2].color);
         Draw_Cup(d_[1].x + i, d_[1].y+ord(i>0)+ord(i>4)+ord(i>6)-ord(i>9)-ord(i>11)-ord(i>15), d_[1].color);
         delay(step_time);
      end;
      if d_[0].x = d_[1].x then
         d_[0].x := d_[2].x
      else if d_[0].x = d_[2].x then
         d_[0].x := d_[1].x;
      d_[4].color := d_[1].color;
      d_[1].color := d_[2].color;
      d_[2].color := d_[4].color;
      d_[4].color := d_[-1].color;
      d_[-1].color := d_[-2].color;
      d_[-2].color := d_[4].color;
   end;
   if num = 3 then
   begin
      for i: integer := 1 to 16 do
      begin
         Draw_Cup(d_[2].x+i-1, d_[2].y-ord((i-1)>0)-ord((i-1)>4)-ord((i-1)>6)+ord((i-1)>9)+ord((i-1)>11)+ord((i-1)>15), 0);
         Draw_Cup(d_[3].x-i+1, d_[3].y+ord((i-1)>0)+ord((i-1)>4)+ord((i-1)>6)-ord((i-1)>9)-ord((i-1)>11)-ord((i-1)>15), 0);
         Draw_Cup(d_[2].x + i, d_[2].y-ord(i>0)-ord(i>4)-ord(i>6)+ord(i>9)+ord(i>11)+ord(i>15), d_[2].color);
         Draw_Cup(d_[3].x - i, d_[3].y+ord(i>0)+ord(i>4)+ord(i>6)-ord(i>9)-ord(i>11)-ord(i>15), d_[3].color);
         delay(step_time);
      end;
      if d_[0].x = d_[2].x then
         d_[0].x := d_[3].x
      else if d_[0].x = d_[3].x then
         d_[0].x := d_[2].x;
      d_[4].color := d_[3].color;
      d_[3].color := d_[2].color;
      d_[2].color := d_[4].color;
      d_[4].color := d_[-3].color;
      d_[-3].color := d_[-2].color;
      d_[-2].color := d_[4].color;
   end;
   if num = 4 then
   begin
      for i: integer := 1 to 16 do
      begin
         Draw_Cup(d_[3].x-i+1, d_[3].y-ord((i-1)>0)-ord((i-1)>4)-ord((i-1)>6)+ord((i-1)>9)+ord((i-1)>11)+ord((i-1)>15), 0);
         Draw_Cup(d_[2].x+i-1, d_[2].y+ord((i-1)>0)+ord((i-1)>4)+ord((i-1)>6)-ord((i-1)>9)-ord((i-1)>11)-ord((i-1)>15), 0);
         Draw_Cup(d_[3].x - i, d_[3].y-ord(i>0)-ord(i>4)-ord(i>6)+ord(i>9)+ord(i>11)+ord(i>15), d_[3].color);
         Draw_Cup(d_[2].x + i, d_[2].y+ord(i>0)+ord(i>4)+ord(i>6)-ord(i>9)-ord(i>11)-ord(i>15), d_[2].color);
         delay(step_time);
      end;
      if d_[0].x = d_[3].x then
         d_[0].x := d_[2].x
      else if d_[0].x = d_[2].x then
         d_[0].x := d_[3].x;
      d_[4].color := d_[3].color;
      d_[3].color := d_[2].color;
      d_[2].color := d_[4].color;
      d_[4].color := d_[-3].color;
      d_[-3].color := d_[-2].color;
      d_[-2].color := d_[4].color;
   end;
   if num = 5 then
   begin
      for i: integer := 1 to 32 do
      begin
         Draw_Cup(d_[1].x+i-1, d_[1].y-ord((i-1)>0)-ord((i-1)>4)-ord((i-1)>6)+ord((i-1)>25)+ord((i-1)>27)+ord((i-1)>31), 0);
         Draw_Cup(d_[3].x-i+1, d_[3].y+ord((i-1)>0)+ord((i-1)>4)+ord((i-1)>6)-ord((i-1)>25)-ord((i-1)>27)-ord((i-1)>31), 0);
         Draw_Cup(d_[1].x + i, d_[1].y-ord(i>0)-ord(i>4)-ord(i>6)+ord(i>25)+ord(i>27)+ord(i>31), d_[1].color);
         Draw_Cup(d_[2].x, d_[2].y, d_[2].color);
         Draw_Cup(d_[3].x - i, d_[3].y+ord(i>0)+ord(i>4)+ord(i>6)-ord(i>25)-ord(i>27)-ord(i>31), d_[3].color);
         delay(step_time);
      end;
      if d_[0].x = d_[1].x then
         d_[0].x := d_[3].x
      else if d_[0].x = d_[3].x then
         d_[0].x := d_[1].x;
      d_[4].color := d_[3].color;
      d_[3].color := d_[1].color;
      d_[1].color := d_[4].color;
      d_[4].color := d_[-3].color;
      d_[-3].color := d_[-1].color;
      d_[-1].color := d_[4].color;
   end;
   if num = 6 then
   begin
      for i: integer := 1 to 32 do
      begin
         Draw_Cup(d_[3].x-i+1, d_[3].y-ord((i-1)>0)-ord((i-1)>4)-ord((i-1)>6)+ord((i-1)>25)+ord((i-1)>27)+ord((i-1)>31), 0);
         Draw_Cup(d_[1].x+i-1, d_[1].y+ord((i-1)>0)+ord((i-1)>4)+ord((i-1)>6)-ord((i-1)>25)-ord((i-1)>27)-ord((i-1)>31), 0);
         Draw_Cup(d_[3].x - i, d_[3].y-ord(i>0)-ord(i>4)-ord(i>6)+ord(i>25)+ord(i>27)+ord(i>31), d_[3].color);
         Draw_Cup(d_[2].x, d_[2].y, d_[2].color);
         Draw_Cup(d_[1].x + i, d_[1].y+ord(i>0)+ord(i>4)+ord(i>6)-ord(i>25)-ord(i>27)-ord(i>31), d_[1].color);
         delay(step_time);
      end;
      if d_[0].x = d_[3].x then
         d_[0].x := d_[1].x
      else if d_[0].x = d_[1].x then
         d_[0].x := d_[3].x;
      d_[4].color := d_[3].color;
      d_[3].color := d_[1].color;
      d_[1].color := d_[4].color;
      d_[4].color := d_[-3].color;
      d_[-3].color := d_[-1].color;
      d_[-1].color := d_[4].color;
   end;
   if num = 7 then
   begin
      for i: integer := 1 to 6 do
      begin
         Draw_Cup(d_[1].x, d_[1].y - i + 1, 0);
         Draw_Cup(d_[2].x, d_[2].y - i + 1, 0);
         Draw_Cup(d_[3].x, d_[3].y - i + 1, 0);
         Draw_Ball(d_[0].x, d_[0].y, d_[0].color);
         Draw_Cup(d_[1].x, d_[1].y - i, d_[1].color);
         Draw_Cup(d_[2].x, d_[2].y - i, d_[2].color);
         Draw_Cup(d_[3].x, d_[3].y - i, d_[3].color);
         delay(step_time);
      end;
   end;
   if num = 8 then
   begin
      for i: integer := 1 to 6 do
      begin
         Draw_Cup(d_[1].x, d_[1].y - i + 1, 0);
         Draw_Cup(d_[2].x, d_[2].y - i + 1, 0);
         Draw_Cup(d_[3].x, d_[3].y - i + 1, 0);
         Draw_Ball(d_[-1].x, d_[-1].y, d_[-1].color);
         Draw_Ball(d_[-2].x, d_[-2].y, d_[-2].color);
         Draw_Ball(d_[-3].x, d_[-3].y, d_[-3].color);
         Draw_Cup(d_[1].x, d_[1].y - i, d_[1].color);
         Draw_Cup(d_[2].x, d_[2].y - i, d_[2].color);
         Draw_Cup(d_[3].x, d_[3].y - i, d_[3].color);
         delay(step_time);
      end;
   end;
end;

Procedure Draw_Game_1(j: integer);
begin
   DrawText('[Выбор]', 17, 22, ord(j<>6)*(15-ord(j=0)), 0);
   DrawText('[Выбор]', 33, 22, ord(j<>6)*(15-ord(j=1)), 0);
   DrawText('[Выбор]', 49, 22, ord(j<>6)*(15-ord(j=2)), 0);
   DrawText('[Подтвердить]', 14, 24, ord(j<>6)*(15-ord(j=3)), 0);
   DrawText('[Повторить]', 31, 24, ord(j<>6)*(15-ord(j=4)), 0);
   DrawText('[Назад]', 49, 24, ord(j<>6)*(15-ord(j=5)), 0);
   
end;

Function Draw_Game_1: boolean;
begin
   clrscr;
   Randomize;
   Result := false;
      var d: Tgame1;
      var num_rounds, num_points: integer;
   num_rounds := 0;
   num_points := 0;
   DrawText('TEST Patron 3371', 27, 1, 15, 0);
   DrawText('Получите доступ к привилегиям.', 21, 2, 15, 0);
   Draw_Game_1(d, -1, 100);
   DrawText('Попытка:    0', 60, 4, 15, 0);
   DrawText('Побед:      0', 60, 6, 15, 0);
   DrawText('Поражений:  0', 60, 8, 15, 0);
   Draw_Game_1(d, -3, 100);
   delay(2000);
   Draw_Game_1(d, 0, 100);
   delay(3000);
   var do_that: integer := 1;
   var i: integer := 1;
   while (i<=10) and (do_that<>6) do
   begin
      num_rounds := num_rounds + 1;
      do_that := 4;
      DrawText('Попытка:   '+chr((ord('0')+num_rounds div 10)*(num_rounds div 10)+ord(' ')*ord(num_rounds<10))+chr(ord('0')+num_rounds mod 10), 60, 4, 15, 0);
      DrawText('Побед:     '+chr((ord('0')+num_points div 10)*(num_points div 10)+ord(' ')*ord(num_points<10))+chr(ord('0')+num_points mod 10), 60, 6, 15, 0);
      DrawText('Поражений: '+chr((ord('0')+(num_rounds-num_points-1) div 10)*((num_rounds-num_points-1) div 10)+ord(' ')*ord((num_rounds-num_points-1) div 10))+chr(ord('0')+(num_rounds-num_points-1) mod 10), 60, 8, 15, 0);
      while (do_that = 4) do
      begin
         var j: integer := 1;
         while j <= 2*i do
         begin
            var k: integer;
            k := random(1, 6);
            Draw_Game_1(d, k, 12);
            j := j + 1;
         end;
         var now_pos: integer := 0;
         Draw_Game_1(now_pos);
         Repeat
            ReadCod(cod);
            if CodIs(cod,0,37) then
               now_pos := (now_pos div 3)*3 + (now_pos + 2) mod 3;
            if CodIs(cod,0,38) or CodIs(cod,0,40) then
               now_pos := (((now_pos + 3) div 3) mod 2)*3 + (now_pos) mod 3;
            if CodIs(cod,0,39) then
               now_pos := (now_pos div 3)*3 + (now_pos + 1) mod 3;
            Draw_Game_1(now_pos);
         until CodIs(cod,13,0) or CodIs(cod,27,0);
         Draw_Game_1(6);
         do_that := now_pos;
         if now_pos = 0 then
         begin
            if d[0].x = d[1].x then
            num_points := num_points + 1;
         end;
         if now_pos = 1 then
         begin
            if d[0].x = d[2].x then
            num_points := num_points + 1;
         end;
         if now_pos = 2 then
         begin
            if d[0].x = d[3].x then
            num_points := num_points + 1;
         end;
         if (now_pos = 5) or CodIs(cod, 27, 0) then
         begin
            do_that := 6;
         end
         else
         begin
            Draw_Game_1(d, 7, 100);
            DrawText('Попытка:   '+chr((ord('0')+num_rounds div 10)*(num_rounds div 10)+ord(' ')*ord(num_rounds<10))+chr(ord('0')+num_rounds mod 10), 60, 4, 15, 0);
            DrawText('Побед:     '+chr((ord('0')+num_points div 10)*(num_points div 10)+ord(' ')*ord(num_points<10))+chr(ord('0')+num_points mod 10), 60, 6, 15, 0);
            DrawText('Поражений: '+chr((ord('0')+(num_rounds-num_points) div 10)*((num_rounds-num_points) div 10)+ord(' ')*ord((num_rounds-num_points) div 10))+chr(ord('0')+(num_rounds-num_points) mod 10), 60, 8, 15, 0);
            delay(1000);
            Draw_Game_1(d, 0, 100);
            delay(1000);
            Draw_Game_1(6);
         end;
      end;
      if (i = 3) then
      begin
         Draw_Game_1(d, 7, 100);
         delay(1000);
         Draw_Game_1(d, -2, 100);
         Draw_Game_1(d, -3, 100);
         delay(1000);
         Draw_Game_1(d, 0, 100);
         delay(1000);
      end;
      i := i + 1;
   end;
   if num_points < 10 then
   begin
      DrawText('В следующий раз попробуйте ни разу не ошибиться.', 4, 24, 12, 0);
      delay(3000);
   end
   else
   begin
      DrawText('Так легко справились с испытанием? А как вы справитесь со следующим?', 4, 24, 10, 0);
      delay(3000);
      DrawText('Так легко справились с испытанием? А как вы справитесь со следующим?', 4, 24, 0, 0);
      Draw_Game_1(d, 8, 100);
      delay(1000);
      Draw_Game_1(d, -1, 100);
      Draw_Game_1(d, -5, 100);
      delay(1000);
      Draw_Game_1(d, -6, 100);
      delay(1000);
      while (i<=20) and (do_that<>6) do
      begin
         num_rounds := num_rounds + 1;
         do_that := 4;
         DrawText('Попытка:   '+chr((ord('0')+num_rounds div 10)*(num_rounds div 10)+ord(' ')*ord(num_rounds<10))+chr(ord('0')+num_rounds mod 10), 60, 4, 15, 0);
         DrawText('Побед:     '+chr((ord('0')+num_points div 10)*(num_points div 10)+ord(' ')*ord(num_points<10))+chr(ord('0')+num_points mod 10), 60, 6, 15, 0);
         DrawText('Поражений: '+chr((ord('0')+(num_rounds-num_points-1) div 10)*((num_rounds-num_points-1) div 10)+ord(' ')*ord((num_rounds-num_points-1) div 10))+chr(ord('0')+(num_rounds-num_points-1) mod 10), 60, 8, 15, 0);
         while (do_that = 4) do
         begin
            var j: integer := 1;
            while j <= 2*i do
            begin
               var k: integer;
               k := random(1, 6);
               Draw_Game_1(d, k, 12);
               j := j + 1;
            end;
            var now_pos: integer := 0;
            var col1, col0: integer;
            col1 := 12;
            col0 := 151515;
            Draw_Game_1(now_pos);
            DrawText('Где:', 3, 22, 15, 0);
            if col1 = 12 then
               DrawText('[красный]', 3, 23, 12, 0);
            if col1 = 10 then
               DrawText('[зелёный]', 3, 23, 10, 0);
            if col1 = 14 then
               DrawText('[жёлтый]', 3, 23, 14, 0);
            DrawText('0', 3, 24, col0 div 10000, 0);
            DrawText('0', 5, 24, col0 div 100 mod 100, 0);
            DrawText('0', 7, 24, col0 mod 100, 0);
            Repeat
               ReadCod(cod);
               if CodIs(cod,0,37) then
                  now_pos := (now_pos div 3)*3 + (now_pos + 2) mod 3;
               if CodIs(cod,0,38) or CodIs(cod,0,40) then
                  now_pos := (((now_pos + 3) div 3) mod 2)*3 + (now_pos) mod 3;
               if CodIs(cod,0,39) then
                  now_pos := (now_pos div 3)*3 + (now_pos + 1) mod 3;
               if CodIs(cod,13,0) then
               begin
                  if now_pos = 0 then
                     col0 := col0 - col0 div 10000 * 10000 + col1*10000;
                  if now_pos = 1 then
                     col0 := col0 - col0 div 100 mod 100 * 100 + col1*100;
                  if now_pos = 2 then
                     col0 := col0 - col0 mod 100 + col1;
                  if col1 = 12 then
                     col1 := 10
                  else if col1 = 10 then
                     col1 := 14
                  else col1 := 12;
               end;
               Draw_Game_1(now_pos);
               DrawText('[=======]', 3, 23, 0, 0);
               DrawText('0', 3, 24, col0 div 10000, 0);
               DrawText('0', 5, 24, col0 div 100 mod 100, 0);
               DrawText('0', 7, 24, col0 mod 100, 0);
               DrawText('Где:', 3, 22, 15, 0);
               if col1 = 12 then
                  DrawText('[красный]', 3, 23, 12, 0);
               if col1 = 10 then
                  DrawText('[зелёный]', 3, 23, 10, 0);
               if col1 = 14 then
                  DrawText('[жёлтый]', 3, 23, 14, 0);   
            until CodIs(cod,27,0) or (now_pos > 2) and CodIs(cod,13,0);
            Draw_Game_1(6);
            do_that := now_pos;
            if now_pos = 3 then
            begin
               if col0 = d[-1].color*10000+d[-2].color*100+d[-3].color then
               num_points := num_points + 1;
            end;
            if (now_pos = 5) or CodIs(cod, 27, 0) then
            begin
               do_that := 6;
               DrawText('0', 3, 24, 0, 0);
               DrawText('0', 5, 24, 0, 0);
               DrawText('0', 7, 24, 0, 0);
               DrawText('[=======]', 3, 23, 0, 0);
               DrawText('Где:', 3, 22, 0, 0);
               Draw_Game_1(6);
            end
            else
            begin
               Draw_Game_1(d, 8, 100);
               DrawText('Попытка:   '+chr((ord('0')+num_rounds div 10)*ord(num_rounds >= 10)+ord(' ')*ord(num_rounds<10))+chr(ord('0')+num_rounds mod 10), 60, 4, 15, 0);
               DrawText('Побед:     '+chr((ord('0')+num_points div 10)*ord(num_points >= 10)+ord(' ')*ord(num_points<10))+chr(ord('0')+num_points mod 10), 60, 6, 15, 0);
               DrawText('Поражений: '+chr((ord('0')+(num_rounds-num_points) div 10)*ord((num_rounds-num_points) >= 10)+ord(' ')*ord((num_rounds-num_points) < 10))+chr(ord('0')+(num_rounds-num_points) mod 10), 60, 8, 15, 0);
               delay(1000);
               DrawText('0', 3, 24, 0, 0);
               DrawText('0', 5, 24, 0, 0);
               DrawText('0', 7, 24, 0, 0);
               DrawText('[=======]', 3, 23, 0, 0);
               DrawText('Где:', 3, 22, 0, 0);
               Draw_Game_1(d, -6, 100);
               delay(1000);
               Draw_Game_1(6);
            end;
         end;
         if (i = 13) then
         begin
            Draw_Game_1(d, 8, 100);
            delay(1000);
            Draw_Game_1(d, -2, 100);
            Draw_Game_1(d, -5, 100);
            delay(1000);
            Draw_Game_1(d, -6, 100);
            delay(1000);
         end;
         i := i + 1;
      end;
      if num_points = 20 then
      begin
         DrawText('Отлично! Доступ открыт! (К следующему тесту! А вы как думали?)', 4, 24, 10, 0);
         result := true;
         delay(3000);
      end
      else
      begin
         DrawText('Сконцентрируйтесь, и, может в следующий раз, вы не ошибётесь.', 4, 24, 12, 0);
         delay(3000);
      end;
   end;
   cod.cod1 := 0;
   cod.cod1 := 0;
end;

begin
   SetWindowTitle('Crypter 1.0');
   randomize;
   s0 := 'Hallo World!';
   s := s0;
   message := 'Строка выше является новой исходной.';
   
   b := true;
   Menu_Set_Next(1, 0, 8);
   cod_menu_num[2] := 4;
   cod_menu_num[3] := 4;
   cod_menu_num[4] := 3;
   cod_menu_num[5] := 4;
   cod_menu_num[6] := 7;
   cod_menu_num[7] := 4;
   cod_menu_num[8] := 4;
   cod_menu_num[9] := 3;
   cod_menu_num[10] := 3;
   cod_menu_num[11] := 7;
   cod_menu_num[12] := 8;
   cod_menu_num[13] := 3;

   while b do
   begin
      // меню 1
         Menu_Pos_Change(1);
         Draw_Menu_1(cod_menu_pos[1]);
         ReadCod(cod);
         if CodIs(cod, 13, 0) then
         begin
            if cod_menu_pos[1] = 0 then
            begin
               Menu_Set_Next(2, 0);
               while b do
               begin
                  // меню 2
                     Menu_Pos_Change(2);
                     Draw_Menu_2(cod_menu_pos[2]);
                     ReadCod(cod);
                     if CodIs(cod, 13, 0) then
                     begin
                        if cod_menu_pos[2] = 0 then
                        begin
                           Draw_Menu_2_0(s0, s);
                           b := false;
                        end;
                        if cod_menu_pos[2] = 1 then
                        begin
                           Menu_Set_Next(3, 0);
                           if path_in <> '' then
                           begin
                              Assign(f, path_in);
                              if CanResetFile(f) then
                              begin
                                 var str, str1: string;
                                 var b1: boolean;
                                 var n1: integer;
                                 n1 := 1;
                                 b1 := false;
                                 readln(f, str);
                                 if str = '' then
                                    str1 := 'Hallo World!'
                                 else
                                    str1 := str;
                                 while b do
                                 begin
                                    // меню 3
                                       Menu_Pos_Change(3);
                                       Draw_Menu_3(cod_menu_pos[3], str1, n1 = 1, eof(f));
                                       ReadCod(cod);
                                       if CodIs(cod, 13, 0) then
                                       begin
                                          if cod_menu_pos[3] = 0 then
                                          begin
                                             if n1 > 1 then
                                             begin
                                                n1 := n1 - 1;
                                                CloseFile(f);
                                                Reset(f);
                                                for i: integer := 1 to n1 do
                                                Readln(f, str);
                                                if str = '' then
                                                   str1 := 'Hallo World!'
                                                else
                                                   str1 := str;
                                             end;
                                          end;
                                          if cod_menu_pos[3] = 1 then
                                          begin
                                             s0 := str1;
                                             s := str1;
                                             b1 := true;
                                             message := 'Строка выше является новой исходной.';
                                          end;
                                          if cod_menu_pos[3] = 2 then
                                          begin
                                             if not eof(f) then
                                             begin
                                                Readln(f, str);
                                                if str = '' then
                                                   str1 := 'Hallo World!'
                                                else
                                                   str1 := str;
                                                n1 := n1 + 1;
                                             end;
                                          end;
                                          if cod_menu_pos[3] = 3 then
                                          begin
                                             b := false;
                                          end;
                                       end;
                                    // меню 3
                                    if CodIs(cod, 27, 0) then b := false;
                                 end;
                                 CloseFile(f);
                                 if b1 then
                                 begin
                                    Write_Out;
                                    b := false;
                                 end;
                              end;
                           end
                           else
                           begin
                              DrawText('Укажите путь к файлу для ввода в настройках!', 10, 8, 14, 0);
                              delay(1000);
                           end;
                           b := false;
                           Menu_Set_Next(1, 0);
                        end;
                        if cod_menu_pos[2] = 2 then
                        begin
                           s := s0;
                           message := 'Строка выше является новой исходной.';
                           Write_Out;
                           var str: string := '<><><><><><><><><><><><><><>';
                           for i: integer := 1 to length(str) do
                           begin
                              DrawText(str[i], 9 + i, 9, 14, 0);
                              DrawText(str[i], 9 + i, 11, 14, 0);
                              Delay(10);
                           end;
                           Delay(50);
                        end;
                        if cod_menu_pos[2] = 3 then
                        begin
                           b := false;
                        end;
                     end;
                  // меню 2
                  if CodIs(cod, 27, 0) then b := false;
               end;
               b := true;
               Menu_Set_Next(1, 0);
            end;
            if cod_menu_pos[1] = 1 then
            begin
               Menu_Set_Next(5, 0);
               while b do
               begin
                  // меню 5
                     Menu_Pos_Change(5);
                     Draw_Menu_5(cod_menu_pos[5]);
                     ReadCod(cod);
                     if CodIs(cod, 13, 0) then
                     begin
                        if cod_menu_pos[5] = 0 then
                        begin
                           if path_out = '' then
                           begin
                              DrawText('Укажите путь к файлу для ввода в настройках!', 10, 6, 14, 0);
                              Delay(1000);
                              b := false;
                           end
                           else
                           begin
                              Assign(f, path_out);
                              if CanAppendFile(f) then
                              begin
                                 writeln(f, s0);
                                 writeln(f, 'Строка выше является исходной.');
                                 CloseFile(f);
                                 DrawText('Успешно.', 10, 7, 10, 0);
                              end
                              else
                                 DrawText('Невозможно.', 10, 7, 12, 0);
                              Delay(1000);
                           end;
                        end;
                        if cod_menu_pos[5] = 1 then
                        begin
                           if path_out = '' then
                           begin
                              DrawText('Укажите путь к файлу для ввода в настройках!', 10, 8, 14, 0);
                              Delay(1000);
                              b := false;
                           end
                           else
                           begin
                              Assign(f, path_out);
                              if CanAppendFile(f) then
                              begin
                                 writeln(f, s);
                                 writeln(f, message);
                                 CloseFile(f);
                                 DrawText('Успешно.', 10, 9, 10, 0);
                              end
                              else
                                 DrawText('Невозможно.', 10, 9, 12, 0);
                              Delay(1000);
                           end;
                        end;
                        if cod_menu_pos[5] = 2 then
                        begin
                           if path_out = '' then
                           begin
                              DrawText('Укажите путь к файлу для ввода в настройках!', 10, 10, 14, 0);
                              Delay(1000);
                              b := false;
                           end
                           else
                           begin
                              Assign(f, path_out);
                              if CanAppendFile(f) then
                              begin
                                 DrawText(char(25), 14, 14, 14, 0);
                                 DrawText(char(24), 14, 16, 14, 0);
                                 DrawText(char(26), 13, 15, 14, 0);
                                 textcolor(15);
                                 var str: string;
                                 readln(str);
                                 writeln(f, str);
                                 CloseFile(f);
                                 DrawText('Успешно.', 10, 11, 10, 0);
                              end
                              else
                                 DrawText('Невозможно.', 10, 11, 12, 0);
                              Delay(1000);
                           end;
                        end;
                        if cod_menu_pos[5] = 3 then
                        begin
                           b := false;
                        end;
                     end;
                  // меню 5
                  if CodIs(cod, 27, 0) then b := false;
               end;
               b := true;
               Menu_Set_Next(1, 0);
            end;
            if cod_menu_pos[1] = 2 then
            begin
               Menu_Set_Next(7, 0);
               while b do
               begin
                  // меню 7
                     Menu_Pos_Change(7);
                     Draw_Menu_7(cod_menu_pos[7]);
                     ReadCod(cod);
                     if CodIs(cod, 13, 0) then
                     begin
                        if cod_menu_pos[7] = 0 then
                        begin
                           var sh_key: integer := 1;
                           Menu_Set_Next(8, 0);
                           while b do
                           begin
                              // меню 8
                                 var str1: string;
                                 str(sh_key, str1);
                                 Menu_Pos_Change(8);
                                 Draw_Menu_8(cod_menu_pos[8]);
                                 DrawText('             Ключ: ', 8, 20 - (26 + length(str1)) div 80, 14, 0);
                                 DrawText(' ', 28, 20 - (26 + length(str1)) mod 80, 15, 0);
                                 write(sh_key);
                                 gotoxy(1, 1);
                                 ReadCod(cod);
                                 if CodIs(cod, 13, 0) then
                                 begin
                                    if cod_menu_pos[8] = 0 then
                                    begin
                                       s := Shif_Cezar(sh_key, s, ABC, false);
                                       message := 'Строка выше является зашифрованной шифром Цезаря.';
                                       Write_Out;
                                    end;
                                    if cod_menu_pos[8] = 1 then
                                    begin
                                       s := Shif_Cezar(sh_key, s, ABC, true);
                                       message := 'Строка выше является расшифрованной шифром Цезаря.';
                                       Write_Out;
                                    end;
                                    if cod_menu_pos[8] = 2 then
                                    begin
                                       DrawText('             Ключ: ', 8, 20 - (26 + length(str1)) div 80, 0, 0);
                                       DrawText(' ', 28, 20 - (26 + length(str1)) mod 80, 0, 0);
                                       write(sh_key);
                                       DrawText('             Ключ: ', 8, 20, 14, 0);
                                       DrawText(' ', 28, 20, 15, 0);
                                       DrawText(char(25), 28, 19, 14, 0);
                                       DrawText(char(24), 28, 21, 14, 0);
                                       DrawText(char(26), 27, 20, 14, 0);
                                       textcolor(15);
                                       var str2: string;
                                       readln(str2);
                                       var cod_, sh_key_: integer;
                                       val(str2, sh_key_, cod_);
                                       if cod_ = 0 then
                                          sh_key := sh_key_
                                       else
                                       begin
                                          DrawText(char(26), 27, 20, 14, 0);
                                          textcolor(0);
                                          write(str2);
                                          DrawText('В качестве ключа укажите целое число!', 28, 20, 12, 0);
                                          Delay(1000);
                                       end;
                                    end;
                                    if cod_menu_pos[8] = 3 then
                                    begin
                                       b := false;
                                    end;
                                 end;
                              // меню 8
                              if CodIs(cod, 27, 0) then b := false;
                           end;
                           b := true;
                           Menu_Set_Next(7, 0);
                        end;
                        if cod_menu_pos[7] = 1 then
                        begin
                           var sh_key: string := 'ABCDEF';
                           Menu_Set_Next(8, 0);
                           while b do
                           begin
                              // меню 8
                                 Menu_Pos_Change(8);
                                 Draw_Menu_8(cod_menu_pos[8]);
                                 DrawText('             Ключ: ', 8, 20 - (26 + length(sh_key)) div 80, 14, 0);
                                 DrawText(sh_key, 29, 20 - (26 + length(sh_key)) mod 80, 15, 0);
                                 gotoxy(1, 1);
                                 ReadCod(cod);
                                 if CodIs(cod, 13, 0) then
                                 begin
                                    if cod_menu_pos[8] = 0 then
                                    begin
                                       s := Shif_Vigener(sh_key, s, ABC, false);
                                       message := 'Строка выше является зашифрованной шифром Виженера.';
                                       Write_Out;
                                    end;
                                    if cod_menu_pos[8] = 1 then
                                    begin
                                       s := Shif_Vigener(sh_key, s, ABC, true);
                                       message := 'Строка выше является расшифрованной шифром Виженера.';
                                       Write_Out;
                                    end;
                                    if cod_menu_pos[8] = 2 then
                                    begin
                                       DrawText('             Ключ: ', 8, 20 - (26 + length(sh_key)) div 80, 0, 0);
                                       DrawText(sh_key, 29, 20 - (26 + length(sh_key)) mod 80, 0, 0);
                                       DrawText('             Ключ: ', 8, 20, 14, 0);
                                       DrawText(char(25), 28, 19, 14, 0);
                                       DrawText(char(24), 28, 21, 14, 0);
                                       DrawText(char(26), 27, 20, 14, 0);
                                       textcolor(15);
                                       var str2: string;
                                       readln(str2);
                                       if str2 = '' then
                                          sh_key := ' '
                                       else
                                          sh_key := str2;
                                    end;
                                    if cod_menu_pos[8] = 3 then
                                    begin
                                       b := false;
                                    end;
                                 end;
                              // меню 8
                              if CodIs(cod, 27, 0) then b := false;
                           end;
                           b := true;
                           Menu_Set_Next(7, 0);
                        end;
                        if cod_menu_pos[7] = 2 then
                        begin
                           Menu_Set_Next(9, 0);
                           while b do
                           begin
                              // меню 9
                                 Menu_Pos_Change(9);
                                 Draw_Menu_9(cod_menu_pos[9]);
                                 ReadCod(cod);
                                 if CodIs(cod, 13, 0) then
                                 begin
                                    if cod_menu_pos[9] = 0 then
                                    begin
                                       s := Shif_Parent(Shif1, s, ABC, false);
                                       message := 'Строка выше является зашифрованной шифром Тритемиуса.';
                                       Write_Out;
                                    end;
                                    if cod_menu_pos[9] = 1 then
                                    begin
                                       s := Shif_Parent(Shif1, s, ABC, true);
                                       message := 'Строка выше является расшифрованной шифром Тритемиуса.';
                                       Write_Out;
                                    end;
                                    if cod_menu_pos[9] = 2 then
                                    begin
                                       b := false;
                                    end;
                                 end;
                              // меню 9
                              if CodIs(cod, 27, 0) then b := false;
                           end;
                           b := true;
                           Menu_Set_Next(7, 0);
                        end;
                        if cod_menu_pos[7] = 3 then
                        begin
                           b := false;
                        end;
                     end;
                  // меню 7
                  if CodIs(cod, 27, 0) then b := false;
               end;
               b := true;
               Menu_Set_Next(1, 0);
            end;
            if cod_menu_pos[1] = 3 then
            begin
               Menu_Set_Next(10, 0);
               var sh_key: string := '';
               while b do
               begin
                  // меню 10
                     Menu_Pos_Change(10);
                     Draw_Menu_10(cod_menu_pos[10]);
                     DrawText('             Ключ: ', 8, 20 - (26 + length(sh_key)) div 80, 14, 0);
                     DrawText(sh_key, 29, 20 - (26 + length(sh_key)) mod 80, 15, 0);
                     gotoxy(1, 1);
                     ReadCod(cod);
                     if CodIs(cod, 13, 0) then
                     begin
                        if cod_menu_pos[10] = 0 then
                        begin
                           s := Hesh1(sh_key, s, ABC);
                           message := 'Строка выше является результатом Хэш-функции.';
                           Write_Out;
                        end;
                        if cod_menu_pos[10] = 1 then
                        begin
                           DrawText('             Ключ: ', 8, 20 - (26 + length(sh_key)) div 80, 0, 0);
                           DrawText(sh_key, 29, 20 - (26 + length(sh_key)) mod 80, 0, 0);
                           DrawText('             Ключ: ', 8, 20, 14, 0);
                           DrawText(char(25), 27, 19, 14, 0);
                           DrawText(char(24), 27, 21, 14, 0);
                           DrawText(char(26), 26, 20, 14, 0);
                           textcolor(15);
                           readln(sh_key);
                        end;
                        if cod_menu_pos[10] = 2 then
                        begin
                           b := false;
                        end;
                     end;
                  // меню 10
                  if CodIs(cod, 27, 0) then b := false;
               end;
               b := true;
               Menu_Set_Next(1, 0);
            end;
            if cod_menu_pos[1] = 4 then
            begin
               if  (s0 = 'TEST Patron 3371') or (s0 = 'Patron 3371') then
               begin
                  for i: integer := 1 to 8 do
                  begin
                     DrawText('Patron 3371', 17 + length(s0), 22 - i + 1, 0, 0);
                     DrawText('Patron 3371', 17 + length(s0), 22 - i, 15, 0);
                     delay(200);
                  end;
                  for i: integer := 1 to 2 + length(s0) do
                  begin
                     DrawText('Patron 3371', 17 + length(s0) - i + 1, 14, 0, 0);
                     DrawText('Patron 3371', 17 + length(s0) - i, 14, 15, 0);
                     delay(200);
                  end;
                  DrawText('TEST Patron 3371', 10, 14, 10, 0);
                  gotoxy(1, 1);
                  ReadCod(cod);
                  if CodIs(cod, 13, 0) then
                  begin
                     var z: boolean := false;
                     if s0 = Shif_Vigener('set_true',s,ABC,true) then
                        z := true;
                     if not z then
                     z := Draw_Game_1;
                     if z then
                     begin
                        Menu_Set_Next(11, 0);
                        while b do
                        begin
                           // меню 11
                              if cod_menu_pos[11] <> 7 then
                                 Menu_Pos_Change(11)
                              else
                              begin
                                 if CodIs(cod,0,37) or CodIs(cod,0,38) then
                                    cod_menu_pos[11] := 5;
                                    if CodIs(cod,0,39) or CodIs(cod,0,40) then
                                    cod_menu_pos[11] := 6;
                              end;
                              if CodIs(cod, 0, 39) and (cod_menu_pos[11] = 5) then
                                 cod_menu_pos[11] := 7;
                              Draw_Menu_11(cod_menu_pos[11]);
                              ReadCod(cod);
                              if CodIs(cod, 13, 0) then
                              begin
                                 if cod_menu_pos[11] = 0 then
                                 begin
                                    Draw_Game_1;
                                 end;
                                 if cod_menu_pos[11] = 1 then
                                 begin
                                    Draw_Menu_11_1;
                                 end;
                                 if cod_menu_pos[11] = 2 then
                                 begin
                                    Draw_Menu_11_2;
                                 end;
                                 if cod_menu_pos[11] = 3 then
                                 begin
                                    Draw_Menu_11_3;
                                 end;
                                 if cod_menu_pos[11] = 4 then
                                 begin
                                    Draw_Menu_11_4;
                                 end;
                                 if cod_menu_pos[11] = 5 then
                                 begin
                                    Menu_Set_Next(12, 0);
                                    while b do
                                    begin
                                       // меню 12
                                          Menu_Pos_Change(12);
                                          Draw_Menu_12(cod_menu_pos[12]);
                                          ReadCod(cod);
                                          if CodIs(cod, 13, 0) then
                                          begin
                                             if cod_menu_pos[12] = 0 then
                                             begin
                                                var str: string := '<><><><><><><><><><><><><><><><><><>';
                                                for i: integer := 1 to length(str) do
                                                begin
                                                   DrawText(str[i], 9 + i, 5, 14, 0);
                                                   DrawText(str[i], 9 + i, 7, 14, 0);
                                                   Delay(10);
                                                end;
                                                ABC := ABC0;
                                             end;
                                             if cod_menu_pos[12] = 1 then
                                             begin
                                                var str: string := '<><><><><><><><><><><><><><><><><><>';
                                                for i: integer := 1 to length(str) do
                                                begin
                                                   DrawText(str[i], 9 + i, 7, 14, 0);
                                                   DrawText(str[i], 9 + i, 9, 14, 0);
                                                   Delay(10);
                                                end;
                                                ABC := ABC1;
                                             end;
                                             if cod_menu_pos[12] = 2 then
                                             begin
                                                var str: string := '<><><><><><><><><><><><><><><><><><>';
                                                for i: integer := 1 to length(str) do
                                                begin
                                                   DrawText(str[i], 9 + i, 9, 14, 0);
                                                   DrawText(str[i], 9 + i, 11, 14, 0);
                                                   Delay(10);
                                                end;
                                                ABC := ABC2;
                                             end;
                                             if cod_menu_pos[12] = 3 then
                                             begin
                                                var str: string := '<><><><><><><><><><><><><><><><><><>';
                                                for i: integer := 1 to length(str) do
                                                begin
                                                   DrawText(str[i], 9 + i, 11, 14, 0);
                                                   DrawText(str[i], 9 + i, 13, 14, 0);
                                                   Delay(10);
                                                end;
                                                ABC := ABC3;
                                             end;
                                             if cod_menu_pos[12] = 4 then
                                             begin
                                                var str: string := '<><><><><><><><><><><><><><><><><><>';
                                                for i: integer := 1 to length(str) do
                                                begin
                                                   DrawText(str[i], 9 + i, 13, 14, 0);
                                                   DrawText(str[i], 9 + i, 15, 14, 0);
                                                   Delay(10);
                                                end;
                                                ABC := ABC4;
                                             end;
                                             if cod_menu_pos[12] = 5 then
                                             begin
                                                var str: string := '<><><><><><><><><><><><><><><><><><>';
                                                for i: integer := 1 to length(str) do
                                                begin
                                                   DrawText(str[i], 9 + i, 15, 14, 0);
                                                   DrawText(str[i], 9 + i, 17, 14, 0);
                                                   Delay(10);
                                                end;
                                                ABC := ABC5;
                                             end;
                                             if cod_menu_pos[12] = 6 then
                                             begin
                                                DrawText('',1,21,0,0);
                                                for i: integer := 1 to 255 do
                                                write(' ');
                                                DrawText(char(25), 28, 20, 14, 0);
                                                DrawText(char(24), 28, 22, 14, 0);
                                                DrawText(char(26), 27, 21, 14, 0);
                                                textcolor(15);
                                                var str2: string;
                                                readln(str2);
                                                var str: string := '<><><><><><><><><><><><><><><><><><>';
                                                for i: integer := 1 to length(str) do
                                                begin
                                                   DrawText(str[i], 9 + i, 5, 14, 0);
                                                   DrawText(str[i], 9 + i, 7, 14, 0);
                                                   Delay(10);
                                                end;
                                                ABC := '';
                                                for i: integer := 1 to length(str2) do
                                                begin
                                                   var v: boolean := true;
                                                   var j: integer := 1;
                                                   while (j <= length(ABC)) and v do
                                                   begin
                                                      if ABC[j] = str2[i] then
                                                         v := false;
                                                      j := j + 1;
                                                   end;
                                                   if v then
                                                   ABC := ABC + str2[i];
                                                end;
                                             end;
                                             if cod_menu_pos[12] = 7 then
                                             begin
                                                b := false;
                                             end;
                                          end;
                                       // меню 12
                                       if CodIs(cod, 27, 0) then b := false;
                                    end;
                                    b := true;
                                    Menu_Set_Next(11, 0);
                                 end;
                                 if cod_menu_pos[11] = 6 then
                                 begin
                                    b := false;
                                 end;
                                 if cod_menu_pos[11] = 7 then
                                 begin
                                    Menu_Set_Next(13, 0);
                                    var str2: string := '';
                                    var str3: string := 'неизвестно';
                                    var str4: string := 'неизвестно';
                                    while b do
                                    begin
                                       // меню 13
                                          Menu_Pos_Change(13);
                                          Draw_Menu_13(cod_menu_pos[13]);
                                          DrawText('Код:',22,13,14,0);
                                          DrawText(str2,27,13,13,0);
                                          DrawText('Верность:',17,15,14,0);
                                          DrawText(str3,27,15,14-4*ord(str3='утверждённый')-2*ord(str3='ошибочный'),0);
                                          DrawText('Владелец:',17,17,14,0);
                                          DrawText(str4,27,17,10+4*ord(str4='неизвестно')+2*ord(str4='невозможно')+4*ord(str4='база данных отсутствует')+3*ord(str4='свободный'),0);
                                          ReadCod(cod);
                                          if CodIs(cod, 13, 0) then
                                          begin
                                             if cod_menu_pos[13] = 0 then
                                             begin
                                                DrawText('',27,13,0,0);
                                                for i: integer := 1 to 255 do
                                                write(' ');
                                                DrawText(char(25), 28, 12, 14, 0);
                                                DrawText(char(24), 28, 14, 14, 0);
                                                DrawText(char(26), 27, 13, 14, 0);
                                                textcolor(15);
                                                readln(str2);
                                                str3 := 'неизвестно';
                                                str4 := str3;
                                             end;
                                             if cod_menu_pos[13] = 1 then
                                             begin
                                                var str5: string := str2;
                                                if length(str5) <> 19 then
                                                begin
                                                   str3 := 'ошибочный';
                                                   str4 := 'невозможно';
                                                end
                                                else
                                                begin
                                                   str5 := Shif_Vigener(copy(str5,17,3),copy(str5,1,16),ABC1,true);
                                                   if Hesh1(str5[1]+str5[10]+str5[2],copy(str5,1,10),ABC1) <> copy(str5,11,6) then
                                                   begin
                                                      str3 := 'ошибочный';
                                                      str4 := 'невозможно';
                                                   end
                                                   else
                                                   begin
                                                      var tt: textfile;
                                                      str3 := 'утверждённый';
                                                      Assign(tt, 'bin\data_base.3371');
                                                      if not CanResetFile(tt) then
                                                      begin
                                                         str4 := 'база данных отсутствует';
                                                      end
                                                      else
                                                      begin
                                                         var tt1: string :='';
                                                         var zz1: boolean := false;
                                                         str4 := 'свободный';
                                                         repeat
                                                            Readln(tt,tt1);
                                                            if str2 = tt1 then
                                                            begin
                                                               zz1 := true;
                                                               readln(tt,str4);
                                                            end;
                                                         until zz1 or eof(tt);
                                                         close(tt);
                                                      end;
                                                   end;
                                                end;
                                             end;
                                             if cod_menu_pos[13] = 2 then
                                             begin
                                                b := false;
                                             end;
                                          end;
                                       // меню 13
                                       if CodIs(cod, 27, 0) then b := false;
                                    end;
                                    b := true;
                                    Menu_Set_Next(11, 0);
                                 end;
                              end;
                           // меню 11
                           if CodIs(cod, 27, 0) then b := false;
                        end;
                        b := true;
                        Menu_Set_Next(1, 0);
                     end;
                     cod.cod1 := 0;
                     cod.cod2 := 0;
                  end;
               end
               else
               begin
                  DrawText('Укажите точное название теста!', 28, 20, 12, 0);
                  delay(1000);
               end;
            end;
            if cod_menu_pos[1] = 5 then
            begin
               Menu_Set_Next(4, 0);
               var n, n1: integer;
               n := 0;
               n1 := 12;
               while b do
               begin
                  // меню 4
                     Menu_Pos_Change(4);
                     Draw_Menu_4(cod_menu_pos[4], n, n1);
                     ReadCod(cod);
                     if CodIs(cod, 13, 0) then
                     begin
                        if cod_menu_pos[4] = 0 then
                        begin
                           n := (n + n1 + 1) mod n1;
                           
                        end;
                        if cod_menu_pos[4] = 1 then
                        begin
                           n := (n + n1 - 1) mod n1;
                           
                        end;
                        if cod_menu_pos[4] = 2 then
                        begin
                           b := false;
                        end;
                     end;
                  // меню 4
                  if CodIs(cod, 27, 0) then b := false;
               end;
               b := true;
               Menu_Set_Next(1, 0);
            end;
            if cod_menu_pos[1] = 6 then
            begin
               Menu_Set_Next(6, 0);
               while b do
               begin
                  // меню 6
                     Menu_Pos_Change(6);
                     Draw_Menu_6(cod_menu_pos[6]);
                     ReadCod(cod);
                     if CodIs(cod, 13, 0) then
                     begin
                        if cod_menu_pos[6] = 0 then
                        begin
                           if path_in = '' then
                              DrawText('Путь не указан.', 14, 22, 0, 0)
                           else
                              DrawText(path_in, 14, 22, 0, 0);
                           DrawText(char(25), 14, 21, 14, 0);
                           DrawText(char(24), 14, 23, 14, 0);
                           DrawText(char(26), 13, 22, 14, 0);
                           textcolor(15);
                           var str: string;
                           readln(str);
                           if str = '' then
                           begin
                              path_in := '';
                              DrawText('Работа с файлом для ввода данных прекращена.', 14, 22, 14, 0);
                              Delay(1000);
                           end
                           else
                           begin
                              AssignFile(f, str);
                              if CanResetFile(f) then
                              begin
                                 DrawText(str, 14, 22, 0, 0);
                                 DrawText('Успешно получен доступ к файлу.', 14, 22, 10, 0);
                                 CloseFile(f);
                                 path_in := str;
                                 Delay(1000);
                              end
                              else
                              begin
                                 DrawText(str, 14, 22, 0, 0);
                                 DrawText('Доступ к файлу не получен. Проверьте его наличие и свойства.', 14, 22, 12, 0);
                                 Delay(1000);
                              end;
                           end;
                        end;
                        if cod_menu_pos[6] = 1 then
                        begin
                           if path_out = '' then
                              DrawText('Путь не указан.', 14, 22, 0, 0)
                           else
                              DrawText(path_out, 14, 22, 0, 0);
                           DrawText(char(25), 14, 21, 14, 0);
                           DrawText(char(24), 14, 23, 14, 0);
                           DrawText(char(26), 13, 22, 14, 0);
                           textcolor(15);
                           var str: string;
                           readln(str);
                           if str = '' then
                           begin
                              path_out := '';
                              DrawText('Работа с файлом для вывода данных прекращена.', 14, 22, 14, 0);
                              Delay(1000);
                           end
                           else
                           begin
                              AssignFile(f, str);
                              if CanAppendFile(f) then
                              begin
                                 DrawText(str, 14, 22, 0, 0);
                                 DrawText('Успешно получен доступ к файлу.', 14, 22, 10, 0);
                                 CloseFile(f);
                                 path_out := str;
                                 Delay(1000);
                              end
                              else
                              begin
                                 DrawText(str, 14, 22, 0, 0);
                                 DrawText('Доступ к файлу не получен. Проверьте его наличие и свойства.', 14, 22, 12, 0);
                                 Delay(1000);
                              end;
                           end;
                        end;
                        if cod_menu_pos[6] = 2 then
                        begin
                           var str: string := '<><><><><><><><><><><><><><><><><><>';
                           for i: integer := 1 to length(str) do
                           begin
                              DrawText(str[i], 9 + i, 9, 14, 0);
                              DrawText(str[i], 9 + i, 11, 14, 0);
                              Delay(10);
                           end;
                           if path_out <> '' then
                           begin
                              AssignFile(f, path_out);
                              if CanRewriteFile(f) then
                              begin
                                 DrawText('Файл успешно перезаписан.', 14, 21, 10, 0);
                                 CloseFile(f);
                              end
                              else
                                 DrawText('Файл не был перезаписан.', 14, 21, 12, 0);
                              Delay(800);
                           end
                           else
                              begin
                                 DrawText('Путь к файлу не указан.', 14, 21, 14, 0);
                                 Delay(800);
                              end;
                        end;
                        if cod_menu_pos[6] = 3 then
                        begin
                           if path_out <> '' then
                              autosave := not autosave;
                        end;
                        if cod_menu_pos[6] = 4 then
                        begin
                           AssignFile(f, 'bin\settings.3371');
                           if CanRewriteFile(f) then
                           begin
                              writeln(f, path_in);
                              writeln(f, path_out);
                              writeln(f, ord(autosave));
                              DrawText('Настройки сохранены.', 14, 22, 10, 0);
                              CloseFile(f);
                           end
                           else
                              DrawText('Невозможно перезаписать настройки.', 14, 22, 12, 0);
                           Delay(800);
                        end;
                        if cod_menu_pos[6] = 5 then
                        begin
                           AssignFile(f, 'bin\settings.3371');
                           if CanResetFile(f) then
                           begin
                              var p_in: string;
                              var p_out: string;
                              var a_save: char;
                              readln(f, p_in);
                              readln(f, p_out);
                              readln(f, a_save);
                              DrawText('Настройки загружены.', 14, 22, 10, 0);
                              CloseFile(f);
                              if p_in <> '' then
                              begin
                                 AssignFile(f, p_in);
                                 if CanResetFile(f) then
                                 begin
                                    path_in := p_in;
                                    CloseFile(f);
                                 end
                                 else
                                    path_in := '';
                              end
                              else
                                 path_in := '';
                              autosave := false;
                              if p_out <> '' then
                              begin
                                 AssignFile(f, p_out);
                                 if CanAppendFile(f) then
                                 begin
                                    path_out := p_out;
                                    CloseFile(f);
                                    if a_save = '1' then
                                       autosave := true;
                                 end
                                 else
                                    path_out := '';
                              end;
                           end
                           else
                              DrawText('Невозможно загрузить настройки.', 14, 22, 12, 0);
                           Delay(800);
                        end;
                        if cod_menu_pos[6] = 6 then
                        begin
                           b := false;
                        end;
                     end;
                  // меню 6
                  if CodIs(cod, 27, 0) then b := false;
               end;
               b := true;
               Menu_Set_Next(1, 0);
            end;
            if cod_menu_pos[1] = 7 then
            begin
               b := false;
            end;
         end;
      // меню 1
      if CodIs(cod, 27, 0) then b := false;
   end;
   clrscr;
   if CodIs(cod, 13, 0) then
   begin
      DrawText('Crypter for text message.', 27, 1, 15, 0);
      DrawText('Шифрование текстовых сообщений.', 24, 2, 15, 0);
      var str: string := 'Найдите меня ВКонтакте:';
      for i: integer := 1 to length(str) do
      begin
         DrawText(str[i], 17 + i, 4, 10, 0);
         delay(50);
      end;
      str := 'vk.com/denhub';
      for i: integer := 1 to length(str) do
      begin
         DrawText(str[i], 17 + i, 5, 10, 0);
         delay(50);
      end;
      str := 'Спасибо, что вы используете нашу программу.';
      for i: integer := 1 to length(str) do
      begin
         DrawText(str[i], 17 + i, 10, 15, 0);
         delay(20);
      end;
      str := 'До встречи.';
      for i: integer := 1 to length(str) do
      begin
         DrawText(str[i], 17 + i, 11, 15, 0);
         delay(20);
      end;
      DrawText('Используйте ESC, чтобы не смотреть эту замечательную, но долгую заставку.', 4, 14, 15, 0);
      DrawText('{', 18, 17, 15, 0);
      DrawText('}', 59, 17, 15, 0);
      for i: integer := 0 to 39 do
      begin
         Delay(60);
         DrawText('=', 19 + i, 17, 10 + 4 * ord(i > 12) - 2 * ord(i > 25), 0);
      end;
      gotoxy(1, 1);
      Delay(1000);
   end;
end.