Unit Unit_Habilidades;
{$CODEPAGE UTF8}

interface 

type 
    THabilidad = record 
        CodigoHabilidad: String[10];
        Nombre: String[40];
        Categoria: String[30];
        end;

    TarchivoTHabilidades = file of THabilidad;

procedure AbrirArchivoHabilidades(var a: TarchivoTHabilidades);
procedure LeerRegistroArchivoHabilidades(var a: TarchivoTHabilidades; pos:integer; var r: THabilidad);
procedure GuardarRegistroHabilidades(var a:TarchivoTHabilidades; pos:integer; var r:THabilidad);
procedure LeerRegistroHabilidades(var a: TarchivoTHabilidades; var r: THabilidad);
procedure MostrarDatosHabilidades(var r: THabilidad);
function VerificarRepetido(var r: THabilidad):boolean;
procedure BurbujaCodigoHabilidad(var a:TarchivoTHabilidades);
procedure BusquedaBinariaHabilidad(var a: TarchivoTHabilidades;var r: THabilidad; var pos: integer);
procedure AgregarHabilidades(var a: TarchivoTHabilidades;var r: THabilidad; var pos: integer);
procedure BuscarHabilidad(var a: TarchivoTHabilidades;var r: THabilidad; var pos: integer);

implementation

procedure AbrirArchivoHabilidades(var a: TarchivoTHabilidades);
begin
    Assign(a, 'Habilidades.dat');
    {$I-} {Desactiva la comprobación automática}
    Reset(a)
    {$I+}  {Activa la comprobación de la linea 34}

    if IOResult <> 0 then {Si no hay un problema en la comprobación en la línea 35, crea el archivo.}
        Rewrite(a);

end;

procedure LeerRegistroArchivoHabilidades(var a: TarchivoTHabilidades; pos:integer; var r: THabilidad);
begin
    Seek(a, pos);
    Read(a, r);
end;

function VerificarRepetido(var a: TarchivoTHabilidades; codHabilidad : string):boolean;
var 
    r : THabilidad;
    encontrado: boolean;
begin

    encontrado := False;
    seek(a, 0);
    while (not Eof(a)) and (not encontrado) do
    begin
        read(a,r);
        encontrado := (r.codHabilidad = codHabilidad); {Si el Cod. Habilidad del registro leído y el Cod. Habilidad pasado por el parametro son iguales encontrado = True}
    end;

    VerificarRepetido := encontrado;

end;

procedure GuardarRegistroHabilidades(var a:TarchivoTHabilidades; pos:integer; var r:THabilidad);
var
    repetido: boolean;
begin
    repetido := VerificarRepetido(r);
    if not repetido then
    begin
        if(FileSize(a) = 0)then
        begin
            pos := 0;
            Seek(a, pos);
            Write(a, r);
        end
        else
        begin
            pos := FileSize(a);
            Seek(a, pos);
            Write(a, r);
        end;
        writeln('Habilidad Guardada.');
    end
    else
    begin
        Writeln('Ese Codigo Habilidad ya existe.');
    end;
end;

procedure eliminarHabilidad(var a:TarchivoTHabilidades; posicion : integer);
var
    r : THabilidad;
begin
    seek(a, pos);
    r.CodigoHabilidad := '';
    r.Nombre := '';
    r.Categoria := '';
    write(a, r);
end;

procedure LeerRegistroHabilidades(var a: TarchivoTHabilidades; var r: THabilidad);
begin
    with r do  
    begin
        Writeln('Ingrese el codigo de la habilidad: ');
        readln(r.CodigoHabilidad);
        Writeln('Ingrese el nombre de la habilidad: ');
        readln(r.Nombre);
        Writeln('Ingrese la categoria de la habilidad: ');
        readln(r.Categoria);
    end;
end;

procedure MostrarDatosHabilidades(var r: THabilidad);
begin
    if r.Estado then
        Write('Codigo de Habilidad: ', r.CodigoHabilidad, ' | Nombre: ', r.Nombre, ' | Categoria: ', r.Categoria);
end;

procedure ListarHabilidad(var a: TarchivoTHabilidades; pos:integer);
var
    r : THabilidad;
begin
    Seek(a, pos);
    Read(a, r);
    MostrarDatosHabilidades(r);
end;

procedure BurbujaCodigoHabilidad(var a:TarchivoTHabilidades);
var
    lim, i, j: integer;
    r1, r2: THabilidad;
begin
    lim := FileSize(a) - 1;
    for i := 1 to lim - 1 do
    begin
        for j := 1 to lim - i do
        begin
            Seek(a, j);
            Read(a, r1);
            Seek(a, j + 1);
            Read(a, r2);
            if r1.CodigoHabilidad > r2.CodigoHabilidad then
            begin
                Seek(a, j+1);
                Write(a, r1);
                Seek(a, j);
                Write(a, r2);
            end;
        end;
    end;
end;

function BusquedaBinariaHabilidad(var a: TarchivoTHabilidades;var r: THabilidad; buscado: string;): integer;
var
    pri, ult, med, pos: integer;
    aux: THabilidad;
begin

    pri := 0;
    ult := FileSize(a) - 1;
    pos := -1;

    while (pos = -1) and (pri <= ult) do
    begin
        med := (pri + ult) div 2;
        Seek(a, med);
        Read(a, aux);
        if aux.CodigoHabilidad = buscado then
            pos := med
        else if aux.CodigoHabilidad < buscado then
            pri := med + 1
        else
            ult := med - 1;
    end;

    BusquedaBinariaHabilidad := pos;

end;

procedure AgregarHabilidades(var a: TarchivoTHabilidades;var r: THabilidad; var pos: integer);
begin 
    LeerRegistroHabilidad(a,pos,r);
    GuardarRegistroHabilidades(a,pos,r);
end;

procedure BuscarHabilidad(var a: TarchivoTHabilidades;var r: THabilidad; var pos: integer);
begin
    BurbujaCodigoHabilidad(a);
    BusquedaBinariaHabilidad(a,r,pos);
end;

end.