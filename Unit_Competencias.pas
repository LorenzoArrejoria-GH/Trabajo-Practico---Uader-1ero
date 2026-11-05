Unit Unit_Competencias;
{$CODEPAGE UTF8}

interface 

uses Unit_Estudiantes,Unit_Habilidades; 

type 
    TCompetencia = record 
        Legajo: String[10];
        CodigoHabilidad: String[10];
        NivelDominio: String[10];
        end;

    TarchivoCompetencias = file of TCompetencia;

procedure AbrirArchivoCompetencias(var a: TArchivoCompetencias);
procedure LeerRegistroCompetencias(var a: TArchivoCompetencias; pos:integer; var r: TCompetencia);
function ExisteCompetencia(var a:TArchivoCompetencias;legajo,codHabilidad:string): boolean;
procedure AgregarCompetencia(var a:TArchivoCompetencias; var r: TCompetencia; legajo, codHabilidad : string);
procedure ListarCompetencia(var a:TArchivoCompetencias;);
procedure OrdenadoBurbujaCompetencia(var a:TArchivoCompetencias;);
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
        while (not Eof (a)) and (not encontrado)
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

procedure CargarCompetencia(var a:TArchivoCompetencias; var r: TCompetencia; legajo, codHabilidad : string);
begin
    writeln('Ingrese el Nivel de Dominio de habilidad: ');
    read(r.NivelDominio);
    r.CodigoHabilidad := codHabilidad;
    r.Legajo := legajo;
end;

{procedure AgregarCompetencia(var a: TarchivoCompetencias; var r: TCompetencia; legajo, codHabilidad : string);
begin 
    CargarCompetencia(a,r,legajo,codHabilidad);
    GuardarRegistro(a,pos,r);
end;}

end.