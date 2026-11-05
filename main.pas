program TP_Final;
{$CODEPAGE UTF8}

uses
    Unit_Competencias, Unit_Estudiantes, Unit_Habilidades, crt;
var 
    opcionGeneral, opcionHabilidad, opcionModificar : byte;
    opcionAgregar : char;
    legajoabuscar, codigohabilidad : string[10];

    archivoEstudiantes: TarchivoEstudiante;
    archivoHabilidades: TarchivoTHabilidades;
    archivoCompetencias: TarchivoCompetencias; 

    registroEstudiante: TEstudiante;
    registroHabilidad: THabilidad;
    registroCompetencias: TCompetencia;
    
    posicionEstudiante: integer; 
    posicionHabilidad: integer; 
    posicionCompetencia: integer; 

//PROCEDURES :v
procedure CrearArchivos(var a1: TarchivoEstudiante; var a2: TarchivoTHabilidades; var a3: TarchivoCompetencias);
begin 
    CrearArchivoEstudiantes(a1);
    CrearArchivoHabilidades(a2);
    CrearArchivoCompetencias(a3);
end;

procedure AbrirArchivos(var a1:TarchivoEstudiante; var a2: TarchivoTHabilidades; var a3: TarchivoCompetencias);
begin
    AbrirArchivoEstudiantes(a1);
    AbrirArchivoHabilidades(a2);
    AbrirArchivoCompetencias(a3);
end;

procedure CerrarArchivos(var a1:TarchivoEstudiante; var a2: TarchivoTHabilidades; var a3: TarchivoCompetencias);
begin
    CerrarArchivoEstudiantes(a1);
    CerrarArchivoHabilidades(a2);
    CerrarArchivoCompetencias(a3);
end;

procedure menuPrincipal();
begin
    Writeln();
    Writeln('----------- MENÚ PRINCIPAL ------------');
    Writeln('1. Agregar un nuevo estudiante y sus habilidades.');
    Writeln('2. Modificar un estudiante existente y sus habilidades.');
    writeln('Ingrese una opcion: ');
end;

procedure menuHabilidad();
begin
    Writeln();
    Writeln('----------- MODIFICACION ------------');
    Writeln('1. Modificar estudiante.');
    Writeln('2. Modificar Habilidades.');
    Writeln('3. Modificar Competencias.');
    writeln('Ingrese una opcion: ');
end;

begin 
// PROGRAMA PRINCIPAL  :)    
    CrearArchivos(archivoEstudiantes, archivoHabilidades, archivoCompetencias);
    AbrirArchivos(archivoEstudiantes, archivoHabilidades, archivoCompetencias);
    menuPrincipal();
    readln(opcionGeneral);

    case opcionGeneral of
    begin
        1: 
        begin
        //EN UN ESTUDIANTE CARGAR MÁS DE 1 HABILIDAD PARA TOMAR EL DNI Y EL LEGAJO DEL ESTUDIANTE Y FUSIONAR NUESTRA UNIT COMPETENCIAS CON LAS DE HABILIDADES Y ESTUDIANTES
            AgregarEstudiantes(archivoEstudiantes, registroEstudiantes, posicionEstudiante);
            writeln('Desea agregar una habilidad? (S/N): ');
            read(opcionAgregar);
            while(opcionAgregar = 'S') do
            begin
                AgregarHabilidad(archivoHabilidades, registroHabilidad, posicionHabilidades);
                AgregarCompetencia(archivoCompetencias, registroCompetencia, registroEstudiantes.Legajo, registroHabilidad.CodigoHabilidad);
                writeln('Desea agregar alguna otra habilidad? (S/N): ');
                read(opcionAgregar);
            end;
        end;
        2:
        begin
            menuModificar();   
            read(opcionModificar);
            case opcionModificar of
            begin
                1:
                    Writeln('Ingrese el legajo del estudiante.');
                    read(legajoabuscar);
                    BuscarEstudiante(archivoEstudiantes, registroEstudiante, posicionEstudiante, legajoabuscar);
                    CargarEstudiante(archivoEstudiantes, registroEstudiante);
                    GuardarRegistroEstudiante(archivoEstudiantes, posicionEstudiante, registroEstudiante)
                2:
                    Writeln('Ingrese el legajo del estudiante.');
                    read(legajoabuscar);
                else:
                
            end;
        end;

    end;
    AgregarEstudiantes(archivoEstudiantes,posicion,registroEstudiante);
    BuscarEstudiante(archivoEstudiantes,registroEstudiante,posicion);
    
    
    BuscarHabilidad(archivoHabilidades,registroHabilidad,posicion);

end.