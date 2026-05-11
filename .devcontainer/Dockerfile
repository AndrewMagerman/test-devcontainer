FROM debian:bookworm

ARG NVIM_VERSION=v0.12.0
ARG TARGETARCH

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    bc \
    git \
    curl \
    zsh \
    sudo \
    locales \
    unzip \
    ca-certificates \
    wget \
    build-essential \
    python3 \
    python3-venv \
    ripgrep fd-find \
    tree \
    tmux \
    clangd \
    clang-format \
 && ln -sf /usr/bin/fdfind /usr/local/bin/fd \
 && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN chsh -s "$(command -v zsh)" dev

RUN touch /home/dev/.zshrc && chown dev:dev /home/dev/.zshrc

RUN case "$TARGETARCH" in \
        amd64) NVIM_ARCH=x86_64 ;; \
        arm64) NVIM_ARCH=arm64 ;; \
        *) echo "Unsupported TARGETARCH: $TARGETARCH" && exit 1 ;; \
    esac \
    && curl -fsSLo /tmp/nvim.appimage "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-${NVIM_ARCH}.appimage" \
    && chmod u+x /tmp/nvim.appimage \
    && /tmp/nvim.appimage --appimage-extract \
    && mv squashfs-root /opt/nvim \
    && rm -f /tmp/nvim.appimage \
    && ln -s /opt/nvim/usr/bin/nvim /usr/local/bin/nvim

RUN python3 -m venv /opt/python-tools \
    && /opt/python-tools/bin/pip install --upgrade pip \
    && /opt/python-tools/bin/pip install basedpyright ruff \
    && ln -s /opt/python-tools/bin/basedpyright /usr/local/bin/basedpyright \
    && ln -s /opt/python-tools/bin/basedpyright-langserver /usr/local/bin/basedpyright-langserver \
    && ln -s /opt/python-tools/bin/ruff /usr/local/bin/ruff
 
USER $USERNAME
RUN mkdir -p /home/$USERNAME/.local/share \
    && git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git /home/$USERNAME/.local/share/oh-my-zsh \
    && git clone --depth 1 https://github.com/pyenv/pyenv.git /home/$USERNAME/.pyenv \
    && mkdir -p /home/$USERNAME/.local/share/tmux/plugins \
    && git clone --depth 1 https://github.com/tmux-plugins/tpm.git /home/$USERNAME/.local/share/tmux/plugins/tpm
WORKDIR /home/$USERNAME
