
Algoritmo Sistema_Control_Acceso
	
	Definir i, cont, op como entero; /// Cont y Op no se han utilizado hasta el momento
	Dimension cedula[100],nombre[100],resgistro_vacio[100]
	Dimensión Equipos[6], Laboratorios[6]
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
	i=0
	
	Repetir
		Borrar Pantalla /// Doble borrar pantallas en el menu para mejor legibilidad
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
				i=i+1
				/// Se asigna para recoger su retorno y utilizarlo proximamente
				llamado = Registrar_Usuario(cedula, nombre, i)
				resgistro_vacio[i] <- "" /// Una vez que se crea un nuevo usuario, su registro de entrada sera vacio 
			2:	
				Si nombre[1] == "" Entonces /// Determina si hay un usuario existente, si no hay, se debe crear uno para usar esta opcion
					Escribir "Debe de registrarse como usuario para utilizar esta opcion."
					Esperar 2 Segundos
				SiNo
					resgistro_vacio[i] <- Registrar_Entrada_Salida(resgistro_vacio[i],nombre[i])
					/// Se envian 2 argumentos, el primero se utilizara para validar la existencia de un registro, el segundo imprime el nombre del usuario
					/// Se guarda en el arreglo con la iteracion correspondiente al usuario, esto con el fin de validar a todos por separado
				FinSi
			3:
				//Gestionar_Aulas(Aulas)
				/// se pide la aula que desea verle el horario xd
				Imprimir "Digite una opcion"
				Escribir "1. Aula 1"
				Escribir "2. Aula 2"
				Escribir "3. Aula 3"
				leer aula
				Mostrar_Horario_Aulas(aula)
				Esperar Tecla 
				
				
			4:
				Escribir "Seleccione una opción: "
				Escribir "1. Solicitar equipo"
				Escribir "2. Solicitar laboratorio móvil"
				Leer seleccion
				Solicitar_Equipo_Laboratorio(Equipos, Laboratorios, seleccion)
			5:
				Escribir "Gracias por usar el sistema"
			De Otro Modo:
				Escribir "Opci n inv lida, intente de nuevo."
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


SubAlgoritmo Solicitar_Equipo_Laboratorio(Equipos, Laboratorios, seleccion)
	
	Segun seleccion Hacer
		1:
			Escribir "Lista de equipos disponibles:"
			i = 1
			Repetir
				Si Equipos[i] == "" Entonces
					
				FinSi
				Escribir i, ". ", Equipos[i]
				i = i + 1
			Hasta Que i > 6
			
			Escribir "Seleccione el número de equipo que desea solicitar:"
			Leer seleccion
			Si seleccion > 0 y seleccion < i Entonces
				encontrado = Falso
				i = 1
				Repetir
					Si Equipos[i] == "" Entonces
						
					FinSi
					Si seleccion == i Entonces
						equipo = Equipos[i]
						encontrado = Verdadero
					FinSi
					i = i + 1
				Hasta Que i > 6
				
				Si encontrado == Verdadero Entonces
					Escribir "Ha solicitado el equipo: ", equipo
					Esperar 2 Segundos
				FinSi
			FinSi
			
		2:
			Escribir "Lista de laboratorios móviles disponibles:"
			i = 1
			Repetir
				Si Laboratorios[i] == "" Entonces
					
				FinSi
				Escribir i, ". ", Laboratorios[i]
				i = i + 1
			Hasta Que i > 6
			
			Escribir "Seleccione el número de laboratorio móvil que desea solicitar:"
			Leer seleccion
			Si seleccion > 0 y seleccion < i Entonces
				encontrado = Falso
				i = 1
				Repetir
					Si Laboratorios[i] == "" Entonces
						
					FinSi
					Si seleccion == i Entonces
						laboratorio = Laboratorios[i]
						encontrado = Verdadero
					FinSi
					i = i + 1
				Hasta Que i > 6
				
				Si encontrado == Verdadero Entonces
					Escribir "Ha solicitado el laboratorio móvil: ", laboratorio
					Esperar 2 Segundos
				FinSi
			FinSi
	FinSegun
Fin SubAlgoritmo
