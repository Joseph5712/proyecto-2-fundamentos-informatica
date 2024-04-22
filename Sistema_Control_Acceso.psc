
Algoritmo Sistema_Control_Acceso
	
	// Definir variables
	Definir i, cont, opcion como entero;
	Dimension cedula[100], nombre[100], registro_vacio[100]
	Dimension Equipos[6], Laboratorios[6], Solicitudes[12]
	
	// Inicializar nombres de equipos y laboratorios móviles
	Equipos[1] = "Proyector #1"
	Equipos[2] = "Proyector #2"
	Equipos[3] = "Proyector #3"
	Equipos[4] = "Proyector #4"
	Equipos[5] = "Proyector #5"
	Equipos[6] = "Proyector #6"
	
	Laboratorios[1] = "Laboratorio Móvil #1"
	Laboratorios[2] = "Laboratorio Móvil #2"
	Laboratorios[3] = "Laboratorio Móvil #3"
	Laboratorios[4] = "Laboratorio Móvil #4"
	Laboratorios[5] = "Laboratorio Móvil #5"
	Laboratorios[6] = "Laboratorio Móvil #6"
	
	cont = 0;
	i = 0
	
	// Iniciar el bucle principal del menú
	Repetir
		Borrar Pantalla
		Escribir "Sistema de Control de Acceso"
		Escribir "1. Registrar Usuario"
		Escribir "2. Registrar Entrada/Salida"
		Escribir "3. Gestionar Aulas"
		Escribir "4. Solicitar Equipo/Laboratorio"
		Escribir "5. Salir"
		Leer opcion
		Borrar Pantalla
		
		Segun opcion Hacer
			1:
				i = i + 1
				llamado = Registrar_Usuario(cedula, nombre, i)
				registro_vacio[i] <- ""
			2:	
				Si nombre[1] == "" Entonces
					Escribir "Debe registrarse como usuario para utilizar esta opción."
					Esperar 2 Segundos
				SiNo
					registro_vacio[i] <- Registrar_Entrada_Salida(registro_vacio[i], nombre[i])
				FinSi
			3:
				Imprimir "Digite una opción"
				Escribir "1. Aula 1"
				Escribir "2. Aula 2"
				Escribir "3. Aula 3"
				Leer aula
				Mostrar_Horario_Aulas(aula)
				Esperar Tecla 
			4:
				Escribir "Seleccione una opción: "
				Escribir "1. Solicitar equipo"
				Escribir "2. Solicitar laboratorio móvil"
				Leer seleccion
				Si i > 0 y i <= 100 Entonces
					Solicitar_Equipo_Laboratorio(Equipos, Laboratorios, Solicitudes, seleccion, nombre[i])
				SiNo
					Escribir "Error: No hay usuarios registrados. Por favor, registre al menos un usuario antes de solicitar un equipo o laboratorio móvil."
					Esperar 2 Segundos
				FinSi
			5:
				Escribir "Gracias por usar el sistema"
			De Otro Modo:
				Escribir "Opción inválida, intente de nuevo."
				Esperar 2 Segundos
		Fin Segun
	Hasta Que opcion == 5
Fin Algoritmo



/// Funcion de Registrar Usuario (terminada)
/// Se hace retorno de nombre para leerlo posteriormente en otros apartados
/// Se piden datos del usuario y se hacen sus respectivas validaciones
SubAlgoritmo nombre <- Registrar_Usuario(cedula, nombre, i)
	campo_vacio <- Falso /// Inicializamos este operador logico en particular justamente aqui y no en el codigo principal por simple comodidad de trabajo 
	
	Repetir
		Repetir
			Escribir "Ingresa los datos del usuario ", i, ":"
			Escribir "Ingrese c dula:"
			Leer cedula[i]
			Escribir "Ingrese nombre:"
			Leer nombre[i]
			
			/// Verificamos si los campos estan vacios
			Si cedula[i] == "" O nombre[i] == "" Entonces
				Escribir "Error: los campos no pueden estar vacios, intente nuevamente."
				Esperar 2 Segundos
				Borrar Pantalla
				campo_vacio <- Verdadero
			SiNo
				campo_vacio <- Falso
			FinSi
		Hasta Que campo_vacio == Falso
		
		/// Como es primera iteracion, obviamente no habra ningun usuario que se repita asi que no podemos asiganar i-1 para validacion (no se permiten arreglos en 0)
		Si i==1 Entonces 
			Escribir "Usuario registrado exitosamente."
			Esperar 1 Segundos
		SiNo /// En caso de haber mas usuarios, se valida uno por uno si el nombre que se esta intentado registrar ya existe
			encontrado <- Falso
			Para j<-1 Hasta i Con Paso 1 Hacer
				Si nombre[i] == nombre[i-1] Entonces
					Si encontrado == Falso 
						Escribir "Error: el usuario ", nombre[i], " ya est  registrado, intente nuevamente."
						Esperar 2 Segundos
						Borrar Pantalla
						encontrado <- Verdadero
					FinSi
				FinSi
			FinPara
			Si encontrado == Falso Entonces /// En caso de no haber repeticiones, se crea el usuario
				Escribir "Usuario registrado exitosamento."
				Esperar 1 Segundos
			FinSi
		FinSi
	Hasta Que encontrado == Falso
Fin SubAlgoritmo



/// Funcion de Registro Entrada y Salida (terminada)
SubAlgoritmo resgistro_vacio <- Registrar_Entrada_Salida(resgistro_vacio, nombre)
	Escribir "Registrar Entrada y Salida"
	Escribir "1. Entrada"
	Escribir "2. Salida"
	Leer opcion
	
	Segun opcion Hacer
		1:	
			/// Se hace solicitud de la hora del equipo y se descomprime
			ha <- HoraActual() /// retorna el valor como (12520), por tanto se divide para darle un formato
			hora <- trunc(ha/10000)
			min <- trunc(ha/100)%100
			resgistro_vacio <- "X" /// Escribimos algo para que en la opcion 2 se valide si esta vacio o no
			Escribir "Hora de entrada: ", hora, ":", min, "."
			Escribir "La hora de entrada se ha registrado exitosamente para ", nombre
			Escribir "(Presione una tecla para volver al menu principal)" 
			Esperar Tecla 
			/// La espera de tecla se podria sustituir por esperar 2 segundos, esto de acuerdo a preferencias 
			
		2:
			/// En caso de si estar vacio, significa que no hay registro de entrada, y sin la entrada no se puede hacer la salida
			Si resgistro_vacio == "" Entonces
				Escribir "Error: El usuario ", nombre, " no ha realizado un registro previamente." 
				Escribir "(Presione una tecla para volver al menu principal)"
				Esperar Tecla
			SiNo
				ha <- HoraActual()
				hora <- trunc(ha/10000)
				min <- trunc(ha/100)%100
				Escribir "Hora de salida: ", hora, ":", min, "."
				Escribir "La hora de salida se ha registrado exitosamente para ", nombre
				Escribir "(Presione una tecla para volver al menu principal)"
				Esperar Tecla
			FinSi
		De Otro Modo:
			Escribir "Opci n inv lida, volviendo al menu..."
			Esperar 2 Segundos
	Fin Segun
FinSubAlgoritmo




//Mostrar horarios de las aulas de forma quemada
SubAlgoritmo Mostrar_Horario_Aulas(aula)
	Escribir "Horario de Aulas Disponibles"
	Si aula == 1 Entonces
		Escribir "Lunes: 8:00 AM - 12:00 PM"
		Escribir "Martes: 1:00 PM - 5:00 PM"
		Escribir "Miércoles: 10:00 AM - 2:00 PM"
		Escribir "Jueves: 3:00 PM - 7:00 PM"
		Escribir "Viernes: 9:00 AM - 1:00 PM"
	FinSi
	
	Si aula == 2 Entonces
		Escribir "Lunes: 1:00 PM - 5:00 PM"
		Escribir "Martes: 8:00 AM - 12:00 PM"
		Escribir "Miércoles: 3:00 PM - 7:00 PM"
		Escribir "Jueves: 1:00 PM - 5:00 PM"
		Escribir "Viernes: 11:00 AM - 3:00 PM"
	FinSi
	
	Si aula == 3 Entonces
		Escribir "Lunes: 10:00 AM - 2:00 PM"
		Escribir "Martes: 3:00 PM - 7:00 PM"
		Escribir "Miércoles: 1:00 PM - 5:00 PM"
		Escribir "Jueves: 10:00 AM - 2:00 PM"
		Escribir "Viernes: 1:00 PM - 5:00 PM"
	FinSi
	
	Escribir "Sábado: Cerrado"
	Escribir "Domingo: Cerrado"
	
Fin SubAlgoritmo


SubAlgoritmo Solicitar_Equipo_Laboratorio(Equipos, Laboratorios, Solicitudes, seleccion, nombre)
    Segun seleccion Hacer
        1:
            // Mostrar equipos disponibles
            Escribir "Lista de equipos disponibles:"
            i = 1
            Repetir
                Si Equipos[i] == "" Entonces
                    i = i + 1
                SiNo
                    Si Solicitudes[i] == "" Entonces
                        Escribir i, ". ", Equipos[i]
                    SiNo
                        Escribir i, ". Ocupado por ", Solicitudes[i]
                    FinSi
                    i = i + 1
                FinSi
            Hasta Que i > 6
            
            // Solicitar selección de equipo
            Escribir "Seleccione el número de equipo que desea solicitar:"
            Leer seleccion
            Si seleccion > 0 y seleccion < i Entonces
                Si Solicitudes[seleccion] == "" Entonces
                    Escribir "Ha solicitado el equipo: ", Equipos[seleccion], " (solicitado por ", nombre, ")"
                    // Almacenar la solicitud junto con el nombre del usuario
                    Solicitudes[seleccion] <- nombre
                    Esperar 2 Segundos
                Sino
                    Escribir "Error: Este equipo ya está ocupado por ", Solicitudes[seleccion]
                FinSi
            FinSi
        2:
            // Mostrar laboratorios móviles disponibles
            Escribir "Lista de laboratorios móviles disponibles:"
            i = 1 // Reiniciar i antes de iterar sobre la lista de laboratorios móviles
            Repetir
                Si Laboratorios[i] == "" Entonces
                    i = i + 1
                SiNo
                    Si Solicitudes[i + 6] == "" Entonces // Aquí sumamos 6 para acceder al arreglo de laboratorios móviles en el índice correspondiente
                        Escribir i, ". ", Laboratorios[i]
                    SiNo
                        Escribir i, ". Ocupado por ", Solicitudes[i + 6] // También sumamos 6 aquí para acceder al arreglo de laboratorios móviles en el índice correspondiente
                    FinSi
                    i = i + 1
                FinSi
            Hasta Que i > 6
            
            // Solicitar selección de laboratorio móvil
            Escribir "Seleccione el número de laboratorio móvil que desea solicitar:"
            Leer seleccion
            Si seleccion > 0 y seleccion < i Entonces
                Si Solicitudes[seleccion + 6] == "" Entonces // Sumamos 6 aquí para acceder al arreglo de laboratorios móviles en el índice correspondiente
                    Escribir "Ha solicitado el laboratorio móvil: ", Laboratorios[seleccion], " (solicitado por ", nombre, ")"
                    // Almacenar la solicitud junto con el nombre del usuario
                    Solicitudes[seleccion + 6] <- nombre // Sumamos 6 aquí para acceder al arreglo de laboratorios móviles en el índice correspondiente
                    Esperar 2 Segundos
                Sino
                    Escribir "Error: Este laboratorio móvil ya está ocupado por ", Solicitudes[seleccion + 6]
                FinSi
            FinSi
    FinSegun
Fin SubAlgoritmo





