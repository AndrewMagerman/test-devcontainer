FROM debian:bookworm

# Install core utilities
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    clang \
    pkg-config \
    cmake \
    make \
    git \
    curl \
    zsh \
    sudo \
    socat \
    locales \
    gnupg \
    unzip \
    ca-certificates \
    python3 python3-venv python3-pip \
    nodejs npm \
    wget \
    ripgrep fd-find \
 && ln -sf /usr/bin/fdfind /usr/local/bin/fd \
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

# Install neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.appimage
RUN chmod u+x nvim-linux-arm64.appimage 
RUN ./nvim-linux-arm64.appimage --appimage-extract && \
    mv squashfs-root /opt/nvim && \
    ln -s /opt/nvim/usr/bin/nvim /usr/local/bin/nvim

# --- Install Deno system-wide (/usr/local/bin/deno) ---
# Using the official installer, but installing to /usr/local so PATH "just works"
RUN curl -fsSL https://deno.land/install.sh | DENO_INSTALL=/usr/local sh -s -- -f -q
# Sanity check (optional)
RUN deno --version
 
# Switch to non-root user
USER $USERNAME
WORKDIR /home/$USERNAME

