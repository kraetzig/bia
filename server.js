const app = require('./index');

// Usa a porta definida pelo ambiente (AWS) ou a 8080 por padrão
const PORT = process.env.PORT || 8080;

app.listen(PORT, '0.0.0.0', function() {
  console.log(`App escutando na porta ${PORT}!`);
});
