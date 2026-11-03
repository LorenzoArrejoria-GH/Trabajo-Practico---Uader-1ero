Unit Unit_Estudiantes;
{$CODEPAGE UTF8}

interface 
type 
    TEstudiante = record 
        Legajo: String[10];
        DNI: String[10];
        NombreApellido: String[60];
        Carrera: String[60];
        AnioIngreso: word;
        Promedio: real;
        PorcentajeCarrera: real;
        end;

    TarchivoEstudiante = file of TEstudiante;

procedure CrearArchivoEstudiantes(var a: TarchivoEstudiante);
procedure AbrirArchivoEstudiantes(var a: TarchivoEstudiante);
procedure CerrarArchivoEstudiantes(var a: TarchivoEstudiante);
procedure LeerRegistroEstudiante(var a: TarchivoEstudiante; pos:integer; var r: TEstudiante);
procedure GuardarRegistroEstudiante(var a:TarchivoEstudiante; pos:integer; var r:TEstudiante);
procedure BurbujaLegajo(var a:TarchivoEstudiante);
procedure BusquedaBinariaEstudiante(var a: TarchivoEstudiante;var r: TEstudiante; var pos: integer);
procedure MostrarDatosEstudiante(var r: TEstudiante);

implementation

uses 
    Crt, SysUtils;

procedure CrearArchivoEstudiantes(var a: TarchivoEstudiante);
begin 
    if FileExist('Estudiantes.dat') then
        writeln('El archivo ya existe')
    else 
        Assign(a, 'Estudiantes.dat');
        rewrite(a);
end;

procedure AbrirArchivoEstudiantes(var a: TarchivoEstudiante);
begin
    Assign(a, 'Estudiantes.dat');
    Reset(a)
end;

procedure CerrarArchivoEstudiantes(var a: TarchivoEstudiante);
begin
    Close(a);
end;

procedure LeerRegistroEstudiante(var a: TarchivoEstudiante; pos:integer; var r: TEstudiante);
begin
    Seek(a, pos);
    Read(a, r);
end;

procedure GuardarRegistroEstudiante(var a:TarchivoEstudiante; pos:integer; var r:TEstudiante);
begin
    if(FileSize(a) = 0)then
    begin
        pos := 0;
        Seek(a, pos);     // belezaAAAAAA
        Write(a, r);
    end
    else
    begin
        pos := FileSize(a);
        Seek(a, pos);
        Write(a, r);
    end;
end;

procedure CargarEstudiante(var a:TarchivoEstudiante; var r:TEstudiante);
begin 
    write('Ingrese el nombre y apellido del/la estudiante: ');
    readln(r.NombreApellido);
    write('Ingrese el DNI del/la estudiante: ');
    readln(r.DNI);
    write('Ingrese el Legajo del/la estudiante: ');
    readln(r.Legajo);
    write('Ingrese La Carrera del/la estudiante: ');
    readln(r.Carrera);
    write('Ingrese el Año de Ingreso del/la estudiante: ');
    readln(r.AnioIngreso);
    write('Ingrese el Promedio de la carrera del/la estudiante: ');
    readln(r.Promedio);
    write('Ingrese el Porcentaje de la carrera del/la estudiante: ');
    readln(r.PorcentajeCarrera);
end;

procedure BurbujaLegajo(var a:TarchivoEstudiante);
var
    r1, r2: TEstudiante;
    lim, i, j: integer;
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
            if r1.Legajo > r2.Legajo then
            begin
                Seek(a, j+1);
                Write(a, r1);
                Seek(a, j);
                Write(a, r2);
            end;
        end;
    end;
end;

// NUEVOOOOOOOOOOOOOOOO
procedure BusquedaBinariaEstudiante(var a: TarchivoEstudiante;var r: TEstudiante; var pos: integer; buscado:string[10]);
var 
    pri, ult, med: integer;
    aux: TEstudiante;
    buscado: String;
begin
    pri := 0;
    ult := filesize(a) - 1;
    pos := -1;
    while (pos = -1) and (pri <= ult) do
    begin
        med := (pri + ult) div 2;
        
        seek(a,med); //POSICIONO EL PUNTERO AL MEDIO 
        read(a,r);
        
        if (r.Legajo = buscado) then
            pos := med
        else
        if r.Legajo > buscado then
            ult := med - 1
        else
            pri := med + 1;
    end;
end;
procedure MostrarDatosEstudiante(var r: TEstudiante);
begin 
    writeln('Nombre y apellido: ',r.NombreApellido);
    writeln('DNI: ',r.DNI);
    writeln('Legajo: ',r.Legajo);
    writeln('Carrera: ',r.Carrera);
    writeln('Año de Ingreso: ',r.AnioIngreso);
    writeln('Promedio en la Carrera: ',r.Promedio);
    writeln('Porcentaje de la Carrera: ',r.PorcentajeCarrera);
end;

procedure AgregarEstudiantes(var a: TarchivoEstudiante;var r: TEstudiante; var pos: integer);
begin 
    CargarEstudiante(a,r);
    GuardarRegistro(a,pos,r);
end;

procedure BuscarEstudiante(var a: TarchivoEstudiante;var r: TEstudiante; var pos: integer; buscado:string[10]);
var 
    SioNo: char;
begin 
    BurbujaLegajo(a);
    BusquedaBinariaEstudiante(a,r,pos,legajoabuscar);
    MostrarDatosEstudiante(r);
end;

end.