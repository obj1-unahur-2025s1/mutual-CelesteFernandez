class Actividad {
  const idiomas = #{}
  var implicaEsfuerzo = false
  var sirveParaBroncesarse = false
  var dias = 0
  var esInteresante = false

  method dias() = dias
  
  method implicaEsfuerzo() = implicaEsfuerzo

  method sirveParaBroncesarse() = sirveParaBroncesarse

  method esInteresante() {
    return idiomas.size() >= 2
  }

  method idiomas() {
    return idiomas
  }
}

class ViajeDePlaya inherits Actividad {
  const largoDePlaya

  override method dias() {
    return largoDePlaya / 500
  }

  override method implicaEsfuerzo() {
    return largoDePlaya > 1200
  }

  override method sirveParaBroncesarse() {
    return true
  }
}

class ExcursionACiudad inherits Actividad {
  const atraccionesAVisitar 

  override method dias() {
    return atraccionesAVisitar / 2
  }

  override method implicaEsfuerzo() {
    return atraccionesAVisitar.between(5, 8)
  }

  override method sirveParaBroncesarse() {
    return false
  }

  override method esInteresante() {
    return super() or atraccionesAVisitar == 5
  }
}

class ExcursionTropical inherits ExcursionACiudad {
  override method dias() {
    return super() + 1
  }

  override method sirveParaBroncesarse() {
    return true
  }
}

class SalidaDeTrekking inherits Actividad {
  var kilometrosDeSenderos
  var diasDeSol 

  override method dias() {
    return kilometrosDeSenderos /50
  }

  override method implicaEsfuerzo() {
    return kilometrosDeSenderos > 80
  }

  override method sirveParaBroncesarse() {
    return (diasDeSol.between(100, 200) and kilometrosDeSenderos > 120) or diasDeSol > 200
  }

  override method esInteresante() {
    return super() and diasDeSol > 140
  }
}

class ClaseDeGimnasia inherits Actividad {

  override method idiomas() {
    return #{"español"}
  }

  override method dias() {
    return 1
  }

  override method implicaEsfuerzo() {
    return true
  }

  override method sirveParaBroncesarse() {
    return false
  }
}

class Socio {
  const actividades = #{}
  const maximoActividades
  var edad = 0
  const idiomas = #{}

  method initialize() {
    actividades.clear()
  }

  method cumplirAnios() {
    edad += 1
  }

  method edad() {
    return edad
  }

  method esAdoradorDelSol() {
    return actividades.all({a => a.sirveParaBroncesarse()})
  }

  method actividadesEsforzadas() {
    return actividades.filter({a => a.implicaEsfuerzo()})
  }

  method registrarActividad(unaActividad) {
    if (maximoActividades == actividades.size()) {
      self.error("llegó al máximo de actividades") 
    }
    actividades.add(unaActividad)
  }

  method leAtraeAlSocio(unaActividad)

}

class SocioTranquilo inherits Socio {
  override method leAtraeAlSocio(unaActividad) {
    return unaActividad.dias() >= 4
  }
}

class SocioCoherente inherits Socio {
  override method leAtraeAlSocio(unaActividad) {
    return 
      if (self.esAdoradorDelSol()) {
        unaActividad.sirveParaBroncesarse()
      } else {
        unaActividad.implicaEsfuerzo()
      }
  }
}

class SocioRelajado inherits Socio {
  override method leAtraeAlSocio(unaActividad) {
    return !idiomas.intersection(unaActividad.idiomas()).isEmpty()
  }
}