FROM debian:bookworm

# Install core utilities
RUN apt-get update && apt-get install -y \
    git curl zsh sudo locales gnupg ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set up UTF-8 locale
RUN sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Create non-root user
ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

    # Set zsh as the default shell
RUN chsh -s "$(command -v zsh)" dev

# dummy .zshrc to avoid zsh-newuser-install
# real .zshrc will be replaced by chezmoi later
RUN touch /home/dev/.zshrc && chown dev:dev /home/dev/.zshrc


# Switch to non-root user
USER $USERNAME
WORKDIR /home/$USERNAME

