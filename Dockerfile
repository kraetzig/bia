FROM public.ecr.aws/docker/library/node:22-slim

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install --loglevel=error

COPY client/package*.json ./client/
RUN cd client && npm install --legacy-peer-deps --loglevel=error

COPY . .

# Usamos "/" para que o front-end procure a API no mesmo domínio do Load Balancer
RUN cd client && VITE_API_URL=/ npm run build

# Limpeza para o container ficar leve
RUN npm prune --production

EXPOSE 8080

# IMPORTANTE: Verifique se o seu package.json (raiz) inicia o servidor na 8080
CMD [ "npm", "start" ]
