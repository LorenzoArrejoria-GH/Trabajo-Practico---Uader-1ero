Unit Unit_Competencias;
{$CODEPAGE UTF8}

interface 

uses Unit_Estudiantes,Unit_Habilidades; 

type 
    TCompetencia = record 
        Legajo: String[10];
        CodigoHabilidad: String[10];
        NivelDominio: String[10];
        estado : boolean;
        end;

    TarchivoCompetencias = file of TCompetencia;

procedure AbrirArchivoCompetencias(var a: TArchivoCompetencias);
procedure LeerRegistroCompetencias(var a: TArchivoCompetencias; pos:integer; var r: TCompetencia);
function ExisteCompetencia(var a:TArchivoCompetencias;legajo,codHabilidad:string): boolean;
procedure AgregarCompetencia(var a:TArchivoCompetencias; var r: TCompetencia; legajo, codHabilidad : string);
procedure ListarCompetencia(var a:TArchivoCompetencias);
procedure OrdenadoBurbujaCompetencia(var a:TArchivoCompetencias);
{procedure AgregarCompetencia(var a: TarchivoCompetencias; var r: TCompetencia; legajo, codHabilidad : string);}

implementation


procedure AbrirArchivoCompetencias(var a: TArchivoCompetencias);
begin 
    Assign(a, 'competencias.dat');
    {$I-}
    reset(a);
    {$I+}
    if IOResult <> 0 then
    rewrite(a);
end;

function ExisteCompetencia(var TArchivoCompetencias,legajo,codHabilidad: string): boolean;
    var
    reg:TCompetencia;
    encontrado:boolean;
    begin
        encontrado:=False;
        seek(a ,0);
        while (not Eof (a)) and (not encontrado) do
        begin
            read(a,reg);
            encontrado:= (reg.legajo = legajo) and (reg.codHabilidad = codHabilidad);
        end;
    ExisteCompetencia:= encontrado;
    end;
//buscar binario por legajo y ordenar burbuja por dominio


procedure LeerRegistroCompetencias(var a: TArchivoCompetencias; pos:integer; var r: TCompetencia);
begin
    Seek(a, pos);
    Read(a, r);
end;

procedure BurbujaCompetenciaLegajo(var a:TArchivoCOmpetencias);
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

procedure BbinLegajo(var a: TarchivoEstudiante;var r: TEstudiante; var pos: integer; buscado:string);
var 
    pri, ult, med: integer;
    aux: TEstudiante;
begin
    pri := 0;
    ult := filesize(a) - 1;
    pos := -1;
    while (pos = -1) and (pri <= ult) do
    begin
        med := (pri + ult) div 2;
        
        seek(a,med);
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

procedure CargarCompetencia(var a:TArchivoCompetencias; var r: TCompetencia; legajo, codHabilidad : string);
begin
    writeln('Ingrese el Nivel de Dominio de habilidad: ');
    read(r.NivelDominio);
    r.CodigoHabilidad := codHabilidad;
    r.Legajo := legajo;
    r.estado := True;
end;

procedure bajaCompetencia(var a:TarchivoCompetencias; var r:TCompetencia; pos : integer; legajo: string);
begin
    BurbujaLegajo(a);
    BusquedaBinariaEstudiante(a,r,pos,legajo);
    seek(a, pos);
    write(a, r.estado = False);
end;

{procedure AgregarCompetencia(var a: TarchivoCompetencias; var r: TCompetencia; legajo, codHabilidad : string);
begin 
    CargarCompetencia(a,r,legajo,codHabilidad);
    GuardarRegistro(a,pos,r);
end;}

end.