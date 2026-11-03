Unit Unit_Competencias;
{$CODEPAGE UTF8}

interface 
type 
    TCompetencia = record 
        Legajo: String[10];
        CodigoHabilidad: String[10];
        NivelDominio: String[10];
        end;

    TarchivoCompetencias = file of TCompetencia;

procedure CrearArchivoCompetencias(var a: TArchivoCompetencias);
procedure AbrirArchivoCompetencias(var a: TArchivoCompetencias);
procedure CerrarArchivoCompetencias(var a: TarchivoCompetencias);
procedure LeerRegistroCompetencias(var a: TArchivoCompetencias; pos:integer; var r: TCompetencia);
procedure CargarCompetencia(var a:TArchivoCompetencias; var r: TCompetencia; legajo, codHabilidad : string);
{procedure AgregarCompetencia(var a: TarchivoCompetencias; var r: TCompetencia; legajo, codHabilidad : string);}

implementation

uses
  Crt, SysUtils;

procedure CrearArchivoCompetencias(var a: TArchivoCompetencias);
begin 
    if FileExists('Competencias.dat') then
        writeln('El archivo ya existe')
    else 
        Assign(a, 'Competencias.dat');
        rewrite(a);
end;

procedure AbrirArchivoCompetencias(var a: TArchivoCompetencias);
begin 
        Assign(a, 'competencias.dat');
        reset(a);

end;
procedure CerrarArchivoCompetencias(var a: TArchivoCompetencias);
begin
        close(a);
end;
procedure LeerRegistroCompetencias(var a: TArchivoCompetencias; pos:integer; var r: TCompetencia);

begin

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