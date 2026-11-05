program TP_Final;
{$CODEPAGE UTF8}

uses
    Unit_Competencias, Unit_Estudiantes, Unit_Habilidades, crt;
var 
    opcionGeneral : byte;
    opcionAgregar, confirmarEliminado : char;
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

procedure menuPrincipal();
begin
    Writeln();
    Writeln('----------- MENÚ PRINCIPAL ------------');
    Writeln('1. Agregar un nuevo estudiante y sus habilidades.');
    Writeln('2. Modificar un estudiante.');
    Writeln('3. Modificar una habilidad.');
    Writeln('4. Modificar una competencia.');
    Writeln('5. Eliminar un estudiante.');
    Writeln('6. Eliminar una habilidad.');
    Writeln('7. Eliminar una competencia.');
    Writeln('0. Salir.');
    writeln('Ingrese una opcion: ');
end;

begin 
    
    menuPrincipal();
    readln(opcionGeneral);

    while (opcionGeneral <> 0)
    begin
        case opcionGeneral of
        begin
            1: 
            begin
                AgregarEstudiantes(archivoEstudiantes, registroEstudiantes, posicionEstudiante);
                writeln('Desea agregar una habilidad? (S/N): ');
                read(opcionAgregar);
                UpCase(opcionAgregar);
                while(opcionAgregar = 'S') do
                begin
                    AgregarHabilidad(archivoHabilidades, registroHabilidad, posicionHabilidad);
                    AgregarCompetencia(archivoCompetencias, registroCompetencia, registroEstudiantes.Legajo, registroHabilidad.CodigoHabilidad);
                    writeln('Desea agregar alguna otra habilidad? (S/N): ');
                    read(opcionAgregar);
                end;
            end;
            2:
            begin
                Writeln('Ingrese el legajo del estudiante: ');
                read(legajoabuscar);
                BuscarEstudiante(archivoEstudiantes, registroEstudiante, posicionEstudiante, legajoabuscar);
                CargarEstudiante(archivoEstudiantes, registroEstudiante);
                GuardarRegistroEstudiante(archivoEstudiantes, posicionEstudiante, registroEstudiante)
            end;
            3:
            begin
                Writeln('Ingrese el codigo de la habilidad: ');
                read(codigohabilidad)
                BuscarHabilidad(archivoHabilidades, registroHabilidad, posicionHabilidad);
                AgregarHabilidad(archivoHabilidades, registroHabilidad, posicionHabilidad);
            end;
            4:
            begin
                Writeln('Ingrese el legajo del estudiante: ');
                read(legajoabuscar);
                Writeln('Ingrese el codigo de la habilidad: ');
                read(codigohabilidad)
                
            end;
            5:
            begin
                Writeln('Ingrese el legajo del estudiante a eliminar: ');
                read(legajoabuscar);

                Writeln('[AVISO]¿Está seguro que quiere eliminar al estudiante? (S/N): ');
                read(confirmarEliminado);
                UpCase(confirmarEliminado);
                if(confirmarEliminado = 'S') then
                begin
                    BuscarEstudiante(archivoEstudiantes, registroEstudiante, posicionEstudiante, legajoabuscar);
                    eliminarEstudiante(archivoEstudiantes, posicionEstudiante);
                    Writeln('Estudiante eliminado correctamente.');
                end;
            end;
            6:
            begin
                Writeln('Ingrese el codigo de habilidad a eliminar: ');
                read(codigoHabilidad);

                Writeln('[AVISO]¿Está seguro que quiere eliminar al estudiante? (S/N): ');
                read(confirmarEliminado);
                UpCase(confirmarEliminado);
                if(confirmarEliminado = 'S') then
                begin
                    buscar
                    eliminarHabilidad(archivoHabilidades);
                end;
            end;
        end;

        menuPrincipal();
        readln(opcionGeneral);

    end;

end.