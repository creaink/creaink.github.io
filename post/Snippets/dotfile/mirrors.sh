# https://mirrors.ustc.edu.cn
# mirrors.tuna.tsinghua.edu.cn

# APT_MIRRORS: mirrors.tuna.tsinghua.edu.cn, mirrors.aliyun.com, mirrors.ustc.edu.cn
APT_MIRRORS=mirrors.tuna.tsinghua.edu.cn
sudo sed -i "s/\(deb\|security\).debian.org/$APT_MIRRORS/g" /etc/apt/sources.list
sudo sed -i "s/\(archive\|security\).ubuntu.com/$APT_MIRRORS/g" /etc/apt/sources.list

# pip
## PYPI_MIRRORS: pypi.tuna.tsinghua.edu.cn/simple, mirrors.ustc.edu.cn/pypi/web/simple
PYPI_MIRRORS="pypi.tuna.tsinghua.edu.cn/simple/"
printf "[global]\nindex-url=https://$PYPI_MIRRORS" > /etc/pip.conf \
    && printf "[easy_install]\nindex-url=https://$PYPI_MIRRORS" > ~/.pydistutils.cfg \

# maven
sudo mkdir /root/.m2 \
&& sudo echo '<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"\n\
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"\n\
        xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0\n\
                            https://maven.apache.org/xsd/settings-1.0.0.xsd">\n\
        <mirrors>\n\
        <mirror>\n\
            <id>alimaven</id>\n\
            <name>aliyun maven</name>\n\
            <url>http://maven.aliyun.com/nexus/content/groups/public/</url>\n\
            <mirrorOf>central</mirrorOf>\n\
        </mirror>\n\
        </mirrors>\n\
    </settings>\n' \
    >> ~/.m2/settings.xml

# docker
sudo touch /etc/docker/daemon.json
sudo bash -c "cat > /etc/docker/daemon.json" <<EOF
{
  "registry-mirrors": [
    "https://dockerhub.azk8s.cn",
    "https://reg-mirror.qiniu.com",
    "http://hub-mirror.c.163.com"
  ]
}
EOF

# nodejs
npm config set registry https://registry.npm.taobao.org

# msys2

# termux

#
