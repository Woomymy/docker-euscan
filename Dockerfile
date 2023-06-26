FROM gentoo/portage:latest as portage

FROM gentoo/stage3:amd64-nomultilib-openrc
COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo


RUN echo "app-portage/euscan-ng" > /etc/portage/package.accept_keywords
COPY woomy-overlay.conf /etc/portage/repos.conf/
RUN emerge "dev-vcs/git"
RUN emerge --sync
RUN emerge app-portage/euscan-ng gentoolkit

RUN rm -rf /var/cache/distfiles/*

CMD [ "bash" ]
