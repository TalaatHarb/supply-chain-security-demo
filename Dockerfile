FROM node:18

WORKDIR /usr/src/app

# Copy files
COPY malicious-package ./malicious-package
COPY important-project ./important-project

# Vulnerable install (postinstall script will execute)
WORKDIR /usr/src/app/important-project
RUN echo "=== Running vulnerable install ===" && \
    npm install && \
    echo "Contents of malicious output:" && \
    cat ../malicious-package/system_info.txt || echo "No output file found."

# Clean up previous install
RUN rm -rf node_modules ../malicious-package/system_info.txt package-lock.json

# Mitigated install (ignoring scripts)
RUN echo "\n=== Running mitigated install with --ignore-scripts ===" && \
    npm install --ignore-scripts && \
    echo "Contents of malicious output:" && \
    cat ../malicious-package/system_info.txt || echo "No output file found (scripts ignored)."

CMD [ "echo", "Demo completed. See above for results." ]
